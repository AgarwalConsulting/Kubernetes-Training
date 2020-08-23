# Architecture

![Components](../assets/images/components-of-kubernetes.png)

## Components

- Control Plane
- Worker Plane / Nodes
- Addons

### Control Plane components

Control plane components can be run on any machine in the cluster. However, for simplicity, set up scripts typically start all control plane components on the same machine, and do not run user containers on this machine.

- **etcd**: is a persistent, lightweight, distributed, key-value data store developed by CoreOS that reliably stores the configuration data of the cluster, representing the overall state of the cluster at any given point of time.

  > etcd uses [Raft Consensus](https://raft.github.io/) to share state and elect leader in a cluster.

- **kube-apiserver**: The API server is a key component and serves the Kubernetes API using JSON over HTTP, which provides both the internal and external interface to Kubernetes.

- **kube-scheduler**: The scheduler is the pluggable component that selects which node an unscheduled pod (the basic entity managed by the scheduler) runs on, based on resource availability. The scheduler tracks resource use on each node to ensure that workload is not scheduled in excess of available resources.

- **kube-controller-manager**: Control Plane component that runs controller processes.

  > A controller is a reconciliation loop that drives actual cluster state toward the desired cluster state, communicating with the API server to create, update, and delete the resources it manages (nodes, pods, service endpoints, etc).

#### Optional control plane components

- **cloud-controller-manager**: A Kubernetes control plane component that embeds cloud-specific control logic. The cloud controller manager lets you link your cluster into your cloud provider's API, and separates out the components that interact with that cloud platform from components that just interact with your cluster.
  > The cloud-controller-manager only runs controllers that are specific to your cloud provider. If you are running Kubernetes on your own premises, or in a learning environment inside your own PC, the cluster does not have a cloud controller manager.

### Worker Plane components - Nodes

Node components run on every node, maintaining running pods and providing the Kubernetes runtime environment.

- **kubelet**: An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod; responsible for communication between the Kubernetes Master and the Node.

- **kube-proxy**: kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.

- *Container runtime*: The container runtime is the software that is responsible for running containers.

  > Kubernetes supports several container runtimes: Docker, containerd, CRI-O, and any implementation of the Kubernetes CRI (Container Runtime Interface).

### Addons

Addons use Kubernetes resources (DaemonSet, Deployment, etc) to implement cluster features.

- DNS (**CoreDNS**): For Service Discovery, CoreDNS is a flexible, extensible DNS server which can be installed as the in-cluster DNS for pods.

- Web UI (**Dashboard**): Dashboard is a general purpose, web-based UI for Kubernetes clusters. It allows users to manage and troubleshoot applications running in the cluster, as well as the cluster itself.

- Container Resource Monitoring (**Prometheus**): Container Resource Monitoring records generic time-series metrics about containers in a central database, and provides a UI for browsing that data.

- Cluster-level logging: Logs should have a separate storage and lifecycle independent of nodes, pods, or containers. Otherwise, node or pod failures can cause loss of event data. The ability to do this is called cluster-level logging, and such mechanisms are responsible for saving container logs to a central log store with search/browsing interface. Kubernetes provides no native storage for log data, but one can integrate many existing logging solutions into the Kubernetes cluster.

- [Others](https://kubernetes.io/docs/concepts/cluster-administration/addons/)
