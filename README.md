# Kubernetes

[Kubernetes](https://kubernetes.io/) is a container orchestration platform at scale.

## Setup

* kubectl
* [kind](https://github.com/kubernetes-sigs/kind/)

## Getting Started

### Single node cluster using kind

```bash
  kind create cluster
```

### Multi node cluster using Kind

```bash
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
