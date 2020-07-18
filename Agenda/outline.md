# Kubernetes

## What problem am I trying to solve?

- Orchestration
  - Machines
  - Services
  - Resources
    - Storage
    - GPU
    - ...
- Service Discovery
- Networking

## Kubernetes Architecture

- Declarative model
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

## Setting up your own cluster (Optional)

## Kubernetes Controllers

- Namespaces
- Pods
  - Resource constraints
  - Sidecars
- Services
  - Labels & selectors
- Replicasets
  - Scale out & scale in
  - Auto-Healing
- Deployments
  - Rollouts
  - Configuration
    - Strategy
  - Init containers
- Configmap
- Secrets
- Volumes
  - StorageClass
  - PersistentVolumeClaim
  - PersistentVolume
- Daemonset
- Statefulset
- Job

### Probes

- Liveness Probe
- Readiness Probe

## Working with helm

## Understanding ingress
