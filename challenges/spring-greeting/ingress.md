# Ingress

## Step 1: Deploy a ingress controller within kind cluster

You can use either [contour](https://kind.sigs.k8s.io/docs/user/ingress/#contour) or [ingress-nginx](https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx).

## Step 2: Create a Ingress Resource for `spring-greeting`

Similar to [nginx ingress that was demoed](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/examples/nginx-simple/ingress.yaml).

Make sure the host name is `gs.local`.

## Step 3: Simulate a DNS record using a `/etc/hosts`

Edit using `sudo`.

Add the following line:

```txt
127.0.0.1 <host-name>
```

## Step 4: Make sure you are able to access the `spring-greeting` app outside the cluster

```bash
curl -i http://gs.local/greeting
```
