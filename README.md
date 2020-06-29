# Kubernetes

[Kubernetes](https://kubernetes.io/) is a container orchestration platform at scale.

## Setup

```bash
  curl https://raw.githubusercontent.com/AgarwalConsulting/java-training/master/code-samples/11-kubernetes/install.sh -o /tmp/install.sh
  chmod 744 /tmp/install.sh
  /tmp/install.sh
```

Or clone the repo and run `./install.sh`

## Getting Started

### Single node cluster using minikube

```bash
  minikube start --vm-driver=kvm2

  . source.sh
```

### Multi node cluster using Kind

[Kubernetes in Docker](https://github.com/kubernetes-sigs/kind/)

Follow steps in [setup-proxy.md](https://github.com/AgarwalConsulting/java-training/blob/master/code-samples/11-kubernetes/setup-proxy.md)

```bash
  ./build-image.sh

  kind create cluster --config kind-config.yml
```

## Outline

![Kubernetes](https://upload.wikimedia.org/wikipedia/commons/b/be/Kubernetes.png)

[Glossary](https://kubernetes.io/docs/reference/glossary)

* Namespace
* Control Plane
* Creating your first deployment

  `kubectl create deployment gs-rest --image=gauravagarwalr/spring-greeting:latest`

* Setup Kubernetes [dashboard](https://github.com/kubernetes/dashboard)
* Creating a guestbook service

## Resources

In-browser Hands-on: [Playground](https://www.katacoda.com/courses/kubernetes)

Workshops:

* [Basic](https://github.com/gsaslis/kubernetes-basics-workshop)
* [Advanced](https://github.com/GoogleCloudPlatform/kubernetes-workshops)

Videos:

* [Kubernetes 101 Workshop](https://www.youtube.com/watch?v=H-FKBoWTVws)
