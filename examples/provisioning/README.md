# Provisioning a Kubernetes Cluster

## Single control-plane cluster [with kubeadm]((https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm))

- [Install kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

- Init the control node using,

```bash
sudo kubeadm init --pod-network-cidr 192.168.0.0/16
```

- Join the workers (other machines) to the control plane using,

```bash
sudo kubeadm join `control-node-ip`:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

## Creating Highly Available clusters [with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/)

- While initializing the control node,

```bash
sudo kubeadm init --control-plane-endpoint "LOAD_BALANCER_DNS:LOAD_BALANCER_PORT" --upload-certs
```

## Kubernetes the **HARD** way

For people truly wanting to know the inner nitty-gritty of a Kubernetes cluster, [Kelsey Hightower](https://twitter.com/kelseyhightower)'s : [Kubernetes the hard way](https://github.com/kelseyhightower/kubernetes-the-hard-way).

## Managed Kubernetes

- Google Kubernetes Engine [(GKE)](https://cloud.google.com/kubernetes-engine)
- Amazon Elastic Kubernetes Service [(EKS)](https://aws.amazon.com/eks/)
- Azure Kubernetes Service [(AKS)](https://azure.microsoft.com/en-in/services/kubernetes-service/)
- [DigitalOcean Kubernetes](https://www.digitalocean.com/products/kubernetes/)
- IBM Cloud Kubernetes Service [(IKS)](https://cloud.ibm.com/kubernetes/catalog/about)

and many more...

## Other tools

- [Kops](https://github.com/kubernetes/kops)
- [Kubespray](https://github.com/kubernetes-sigs/kubespray)

and many more...
