# [Calico](https://docs.projectcalico.org/getting-started/kubernetes/self-managed-public-cloud/gce)

## Create the VPC

```bash
gcloud compute networks create example-k8s --subnet-mode custom
```

## Create the k8s-nodes subnet in the example-k8s VPC network

```bash
gcloud compute networks subnets create k8s-nodes \
  --network example-k8s \
  --range 10.240.0.0/24
```

## Create a firewall rule that allows internal communication across TCP, UDP, ICMP and IP in IP (used for the Calico overlay)

```bash
gcloud compute firewall-rules create example-k8s-allow-internal \
  --allow tcp,udp,icmp,ipip \
  --network example-k8s \
  --source-ranges 10.240.0.0/24
```

## Create a firewall rule that allows external SSH, ICMP, and HTTPS

```bash
gcloud compute firewall-rules create example-k8s-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network example-k8s \
  --source-ranges 0.0.0.0/0
```

## Create the controller VM

```bash
gcloud compute instances create controller \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-2 \
    --private-network-ip 10.240.0.11 \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet k8s-nodes \
    --zone us-central1-f \
    --tags example-k8s,controller
```

## Create three worker VMs

```bash
for i in 0 1 2; do
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-2 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet k8s-nodes \
    --zone us-central1-f \
    --tags example-k8s,worker
done
```

## Create the controller node of a new cluster. On the controller VM, execute

```bash
sudo kubeadm init --pod-network-cidr 192.168.0.0/16
```

The final line of the kubeadm init output contains the command for joining your workers to the controller. Run this on each worker, prepending sudo to run it as root. It will look something like this

```bash
sudo kubeadm join 10.240.0.11:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

## Install Calico

### On the controller, install Calico from the manifest:

```bash
curl https://docs.projectcalico.org/manifests/calico.yaml -O
```

If you wish to customize the Calico install, customize the downloaded calico.yaml manifest. Then apply the manifest to install Calico.

```bash
kubectl apply -f calico.yaml
```
