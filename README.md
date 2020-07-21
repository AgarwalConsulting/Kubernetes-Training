# Kubernetes

[Kubernetes](https://kubernetes.io/) is a container orchestration platform at scale.

## Setup

- [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)

### Test Setup

```bash
kind version
```

  kind v0.8.1 go1.14.2 darwin/amd64

```bash
kubectl version
```

  Client Version: version.Info{Major:"", Minor:"", GitVersion:"v0.0.0-master+$Format:%h$", GitCommit:"$Format:%H$", GitTreeState:"", BuildDate:"1970-01-01T00:00:00Z", GoVersion:"go1.14", Compiler:"gc", Platform:"darwin/amd64"}
  The connection to the server localhost:8080 was refused - did you specify the right host or port?

## Getting Started

### Single node cluster using kind

```bash
kind create cluster
```

### Multi node cluster using Kind

- Create

```bash
make k8s-kind-create
```

- Destroy

```bash
make k8s-kind-delete
```

## Outline

![Kubernetes](https://upload.wikimedia.org/wikipedia/commons/b/be/Kubernetes.png)

[Glossary](https://kubernetes.io/docs/reference/glossary)

- Namespace
- Control Plane
- Worker Plane

## Resources

In-browser Hands-on: [Playground](https://www.katacoda.com/courses/kubernetes)

Videos:

- [Kubernetes 101 Workshop](https://www.youtube.com/watch?v=H-FKBoWTVws)
