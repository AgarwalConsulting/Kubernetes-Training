# Writing your own operator

## What is an operator?

An **operator** is a controller that encodes human operational knowledge: how do I run and manage a specific piece of complex software.

It's composed of:

- Resources (Pod, ConfigMap, Route [OpenShift only])
- Controller (ReplicaSet, Deployment, DaemonSet)
- Domain or Application Specific Knowledge (Installing, Scale, Self-Heal, Clean Up, Update, Backup, Restore)

## Controller vs Operator

> A **controller** is a loop that reads desired state (spec), observed cluster state (others’ status), and external state, and the reconciles cluster state and external state with the desired state, writing any observations down (to our own status).

> All of Kubernetes functions on this model.

> An **operator** is a controller that encodes human operational knowledge: how do I run and manage a specific piece of complex software.

> A kubernetes operator is the name of a pattern that consists of a kubernetes controller that adds new objects to the Kubernetes API, in order to configure and manage an application, such as Prometheus or etcd.

> All operators are controllers, but not all controllers are operators.

## Setup Kubebuilder

```bash
./install-kubebuilder.sh
export PATH=$PATH:/usr/local/kubebuilder/bin
```

## A Simple operator

### Create a module and init using kubebuilder

```bash
mkdir -p simple-operator
cd simple-operator
go mod init <your-domain>/simple-operator
kubebuilder init --domain <your-domain>
```

### Init a Web app

```bash
kubebuilder create api --group webapp --version v1 --kind <NewKindName>
```
