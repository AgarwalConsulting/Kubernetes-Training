# Basics (2 Days)

## Life as a DevOps engineer

- Orchestration
  - Machines
  - Services
  - Resources
    - Storage
    - GPU
    - ...
- Service Discovery
- Networking

---

## Kubernetes Architecture

- Intro to Kind / Minikube & Contexts
- CLI tools

### Components

- Control Plane
  - kube-apiserver
  - etcd
  - kube-scheduler
  - kube-controller-manager
  - cloud-controller-manager

- [Raft Consensus](https://raft.github.io/)

- Node
  - kubelet
  - kube-proxy
  - container runtime

- Addons
  - DNS
  - Web UI (Dashboard)
  - Container Resource Monitoring
  - Cluster-level Logging

---

## Kubernetes Concepts

### Workloads

#### Pods

- Relationship between a pod and container
- Declarative model
- Resource constraints primer

- Intro to services
  - Kubernetes model for connecting containers
  - Labels & selectors

#### Controllers

- Replicasets
  - Scale out & scale in
  - Auto-Healing
- Deployments
  - Rollouts
  - Configuration
    - Strategy
- Job
  - CronJob
- Daemonset
- Statefulset

### Configuration

- Configmap
- Secrets

### Storage

- Volumes
  - StorageClass
  - PersistentVolumeClaim
  - PersistentVolume
