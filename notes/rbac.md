# RBAC

- When we learn Kubernetes, we learn a ton of stuff while using administrator privileges. Which is great for learning, but definitely not for production.

- In the real-world, we need different types of users:

  - Cluster Administrators – full control
  - Developers – limited control over their area
  - Operations – limited control or maybe read-only

- Users are not managed in the cluster. So for example there is no User resource type.

- By default users have no access to do anything. Until they’re given a role.

- There are multiple ways to access a cluster as a specific user. Using certificates is the best way. It is a bit verbose, but secure.

- Users are also how processes that don’t live inside the cluster will have access.

## Creating user certificates

You can use OpenSSL to work with certificates.

To create a user, you must:

- Generate a private key
- Generate a certificate signing request (CSR) which includes the user and groups

Then the cluster admin must:

- Generate a certificate from the CSR using the certificate authority (CA) already stored on the cluster.

Then you must:

- Configure `kubectl` to use this certificate to access the cluster

### Steps

#### Let’s create a new user certificate request

- Create a new directory to work with these files:

  `mkdir -p ~/k8s/certs`

- Generate a new private key:

  `openssl genrsa -out ~/k8s/certs/testuser.key 2048`

- Generate the certificate signing request:

  `openssl req -new -key ~/k8s/certs/testuser.key -out ~/k8s/certs/testuser.csr -subj "/CN=testuser/O=devs"`

#### From the CSR, let’s create a new certificate. On a remote cluster, you’d do this from the cluster. For this lab, we’re doing it on our workstation

- Get the certificate authority certificate and key from your cluster. This is if you’re running Kubernetes for Docker Desktop.

  `kubectl cp kube-apiserver-kind-control-plane:etc/kubernetes/pki/ca.crt -n kube-system ~/k8s/certs/ca.crt`

  `kubectl cp kube-apiserver-kind-control-plane:etc/kubernetes/pki/ca.key -n kube-system ~/k8s/certs/ca.key`

- Generate the certificate from the CSR

  `openssl x509 -req -in ~/k8s/certs/testuser.csr -CA ~/k8s/certs/ca.crt -CAkey ~/k8s/certs/ca.key -CAcreateserial -out ~/k8s/certs/testuser.crt -days 500`

- Inspect the new certificate

  `openssl x509 -in ~/k8s/certs/testuser.crt -text -noout`

#### Now that we have our certificate, let’s set up `kubectl` to use it

- First, create a credential with the certificate

`kubectl config set-credentials testuser@local --client-certificate=$HOME/k8s/certs/testuser.crt --client-key=$HOME/k8s/certs/testuser.key --embed-certs=true`

- Set a context which will match up the cluster and your new credential
`kubectl config set-context testuser@local --cluster=docker-desktop --user=testuser@local`

- Set kubectl to use this new context

`kubectl config use-context testuser@local`

- Now try to get some information, like pods. You should see a permission error.
