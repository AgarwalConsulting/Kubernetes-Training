# Kubernetes

[Kubernetes](https://kubernetes.io/) is a container orchestration platform at scale.

## Setup

- `kubectl` [Install](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

  command line tool which allows for simulating multi node k8s cluster

- `kind` [Install](https://kind.sigs.k8s.io/docs/user/quick-start/)

  command line tool which lets you control Kubernetes clusters

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

## Presentation

Start simple http server

```bash
python -m http.server
```

Open `http://localhost:8000`.

Powered by [Remark](https://remarkjs.com). Tips & tricks: https://github.com/gnab/remark/wiki/Markdown.
