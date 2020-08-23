layout: true

.signature[@algogrit]

---

class: center, middle

![Logo](assets/images/k8s-logo-small.png)

# Kubernetes

Gaurav Agarwal

---

# [Agenda](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/Agenda)

- Understanding the Kubernetes architecture

- Understanding built-in Workloads
  - Pods
  - Controllers
  - Storage
  - Networking
  - ...

- Managing & setting up production grade infrastructure

---

class: center, middle

![Me](assets/images/me.png)

Software Engineer & Product Developer

Principal Consultant & Founder @ https://agarwalconsulting.io

ex-Tarka Labs, ex-BrowserStack, ex-ThoughtWorks

---
class: center, middle

# Defining the problem

---
class: center, middle

## Thought Experiment: [Search Engine](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/Problem.md)

---

- cluster of machines
- From ~10 to millions of microservices
- Manage/Share resources efficiently
  - Memory
  - CPU
  - Storage
  - GPU
  - ...
- Fault Tolerance
  - Healing & resiliency
- Isolation
- Networking
  - Service Discovery
- Managing Deployment
- Auto-Scaling
- ...

---
class: center, middle

# Brief History

---

- 2003 – Started at Google as The Borg System to manage Google Search. They needed a sane way to manage their large-scale container clusters! But it was still very primitive compared to what we have today. It becomes big and rather messy, with many different languages and concepts due to it’s organic growth.
- 2013 – Docker hits the scene and really revolutionizes computing by providing build tools, image distribution, and runtimes. This makes containers user friendly and adoption of containers explodes.
- 2014 – 3 Google engineers decide to build a next generation orchestrator that takes many lessons learned into account, built for public clouds, and open sourced. They build Kubernetes. Microsoft, Red Hat, IBM, and Docker join in.
- 2015 – Cloud Native Computing Foundation is created by Google and the Linux Foundation. More companies join in. Kubernetes 1.0 is released, followed by more major upgrades that year. KubeCon is launched.
- 2016 – K8S goes mainstream. Many supporting products are introduced including Minikube, kops, Helm. Rapid releases of big features. More companies join in and the community of passionate people explodes.
- 2017 to now – Kubernetes becomes the dominant orchestration system and de-facto standard for Docker microservices. K8S now has fully managed services by all major cloud providers. Handsome and talented instructors travel the country preaching K8S.

.content-credits[https://www.vergeops.com/]

---

# Running & interacting with Kubernetes locally

## Simulators

- [`minikube`](https://kubernetes.io/docs/tasks/tools/install-minikube/)
  - Restriced to a single node k8s cluster

- [`kind`](https://kind.sigs.k8s.io/docs/user/quick-start/) (preferred for this class!)
  - command line tool which allows for simulating multi node k8s cluster

## K8s CLI Tools

- [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
  - command line tool which lets you control Kubernetes clusters

---
class: center, middle

# Architecture

![Components](assets/images/components-of-kubernetes.png)

---
class: center, middle

## Components

---

- Control Plane

- Worker Plane / Nodes

- Addons

---
class: center, middle

### Control Plane Components

Control plane components can be run on any machine in the cluster. However, for simplicity, set up scripts typically start all control plane components on the same machine, and do not run user containers on this machine.

---
class: center, middle

### Worker Plane components - Nodes

Node components run on every node, maintaining running pods and providing the Kubernetes runtime environment.

---
class: center, middle

### Addons

Addons use Kubernetes resources (DaemonSet, Deployment, etc) to implement cluster features.

---
class: center, middle

# Command Line Tools

---

## `kubeadm`

- The `kubeadm` tool helps you [bootstrap](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/) a minimum viable Kubernetes cluster that conforms to best practices.

  *In fact, you can use `kubeadm` to set up a cluster that will pass the [Kubernetes Conformance tests](https://kubernetes.io/blog/2017/10/software-conformance-certification/).*

- A simple way for you to try out Kubernetes, possibly for the first time.

- A way for existing users to automate setting up a cluster and test their application.

- A building block in other ecosystem and/or installer tools with a larger scope.

.content-credits[https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/]

---

## `kubectl`

- The `kubectl` command line tool lets you control Kubernetes clusters.

- For configuration, kubectl looks for a file named `config` in the `$HOME/.kube` directory.

- You can specify other kubeconfig files by setting the `KUBECONFIG` environment variable or by setting the `--kubeconfig` flag.

- Makes it reasonably easy to work with multiple clusters using: `kubectl config` & `contexts`

.content-credits[https://kubernetes.io/docs/reference/kubectl/overview/]

---
class: center, middle

So, let's get on with it...

---
class: center, middle

# Basics

---
class: center, middle

## Cluster Computing

---
class: center, middle

### Nodes

`Node = machine`

---

- Kubernetes runs your workload by placing containers into Pods to run on Nodes.
- A node may be a virtual or physical machine, depending on the cluster.
- Each node contains the services necessary to run Pods, managed by the control plane.

#### Useful commands

- `kubectl get nodes`
- `-o wide` for more information
- `kubectl describe`

---
class: center, middle

### Running our first container on a Kubernetes cluster

---
class: center, middle

`kubectl run --image=agarwalconsulting/fib-gen fibonacci`

---
class: center, middle

## Workloads

---
class: center, middle

### Pods

---

- Pods are the smallest deployable units of computing that can be created and managed in Kubernetes.

- A Pod *(as in a pod of whales or pea pod)* is a group of one or more containers *(such as Docker containers)*, with shared storage/network, and a specification for how to run the containers.

- A Pod always runs on a Node.

- Every pod gets a unique IP.

- If multiple containers per pod, pods can communicate with localhost.

#### Useful `kubectl` commands

- `kubectl get pods -o`
- `kubectl describe pods`
- `kubectl logs -f <name>`
- `kubectl exec`
- `kubectl delete pod <name>`

---
class: center, middle

#### Relation between Pods and containers

![Pods](assets/images/pods/pods.png)

---
class: center, middle

#### Relation between Nodes and Pods

![Nodes and Pods](assets/images/pods/nodes-ands-pods.png)

---
class: center, middle

Kubernetes supports *declarative* management of objects

---
class: center, middle

#### Writing a pod spec file

---
class: center, middle

##### [API Groups](https://kubernetes.io/docs/concepts/overview/kubernetes-api/#api-groups)

*The API group is specified in a REST path and in the apiVersion field of a serialized object.*

---

##### [Resource Limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)

*When you specify a Pod, you can optionally specify how much of each resource a Container needs.*

*The most common resources to specify are **CPU** and **memory (RAM)**; there are others.*

We will look at them in more detail later.

---

#### Commands

- `kubectl apply -f ...`
- `kubectl diff -f ...`
- `kubectl delete -f ...`
- `kubectl create -f ...`

---
class: center, middle

#### Example: [Nginx-simple](https://github.com/AgarwalConsulting/Kubernetes-Training/tree/master/examples/nginx-simple)

---
class: center, middle

`kubectl port-forward ...`

---
class: center, middle

### Networking, Load Balancing & Discovery: [`service`](https://kubernetes.io/docs/concepts/services-networking/service/)

---

#### Overview

- An abstract way to expose an application running on a set of Pods as a network service.

- The service resource also lets you expose an application running in Pods to be reachable from outside your cluster.

- Containers within a Pod use networking to communicate via loopback.

---
class: center, middle

##### [Labels & Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)

---

- Labels are key/value pairs that are attached to objects, such as pods.

- Selectors are used by controllers/services to identify pods to work with.

- Via a label selector, the client/user can identify a set of objects. The label selector is the core grouping primitive in Kubernetes.

---
class: center, middle

##### [ServiceTypes](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)

ServiceTypes control the way in which a service is exposed.

---

#### Exercise: Service

- File: [examples/specs/service.yaml](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/examples/specs/service.yaml)
- Review the file. Pay attention to the type and ports.
- Apply to cluster
- Can we access the service from our own computer at http://localhost:30080?
- Now go delete your pod and try the URL again. Oh no! Our service is down!
- Don’t delete the service. We’ll use it again shortly.

---
class: center, middle

#### Exercise: Pods & Services

Write a [pod spec](https://github.com/AgarwalConsulting/Kubernetes-Training/tree/master/challenges/spring-greeting/pod.md) & [service spec](https://github.com/AgarwalConsulting/Kubernetes-Training/tree/master/challenges/spring-greeting/service.md) for the [greeting service](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/challenges/spring-greeting).

---
class: center, middle

### Controllers

---

- In general, users shouldn't need to create Pods directly.
  *You will rarely interact directly with pods, except perhaps viewing logs. You will interact with Deployments or ReplicaSets instead.*

- They should almost always use controllers even for singletons, for example, Deployments.

- Controllers provide self-healing with a cluster scope, as well as replication and rollout management.

- Controllers like StatefulSet can also provide support to stateful Pods.

---

#### Natively Supported Controllers (`kind` field)

- ReplicaSet
- ReplicationController
- Deployments
- StatefulSets
- DaemonSet
- Jobs
- ...

---
class: center, middle

#### Controller Spec generators

`kubectl create --dry-run=client -o yaml`

---

##### [Supported](https://kubernetes.io/docs/reference/kubectl/conventions/#generators) Generators

```csv
clusterrole         Create a ClusterRole.
clusterrolebinding  Create a ClusterRoleBinding for a particular ClusterRole.
configmap           Create a configmap from a local file, directory or literal value.
cronjob             Create a cronjob with the specified name.
deployment          Create a deployment with the specified name.
job                 Create a job with the specified name.
namespace           Create a namespace with the specified name.
poddisruptionbudget Create a pod disruption budget with the specified name.
priorityclass       Create a priorityclass with the specified name.
quota               Create a quota with the specified name.
role                Create a role with single rule.
rolebinding         Create a RoleBinding for a particular Role or ClusterRole.
secret              Create a secret using specified subcommand.
service             Create a service using specified subcommand.
serviceaccount      Create a service account with the specified name.
```

---
class: center, middle

#### [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)

---

- When we deleted all pods in previous exercise, our service went down!

- We don’t want to manage pods directly, because they’re mortal.

- Instead we work with *replicasets* to manage the creation and replacement of pods.

- With a *replicaset*, any pods that die will be recreated to maintain the minimum number.

- This is essentially our pod declaration with some additional meta data.

---
class: center, middle

##### Demo: Defining a replicaset for `fibonacci`

---
class: center, middle

![ReplicaSets](assets/images/controllers/replicasets.png)

---

##### How does it work

So what component in Kubernetes makes sure the specified number of replica pods are running? The answer shows the elegance of Kubernetes’ architecture.

- The [`ReplicationController`](https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/) (which is the logic behind the ReplicaSet resource) is always watching the K8s API. When it sees that the number of running pods differs from the ReplicaSet’s configuration, it takes action. It tells K8s to launch pods to make up the gap. The ReplicationController’s job is now done.

- If there are too many pods, the ReplicationController terminates the extra pods. If there are too few, the ReplicationController starts more pods.

- The pod records are created in etcd.

- The scheduler now starts finding nodes for the pods to run.

- When a pod is assigned to a node, the kubelet on the assigned node takes action to start the pod on the node.

- A `ReplicaSet` ensures that a specified number of pod replicas are running at any given time.

---

#### Exercise: ReplicaSet

- File: [examples/specs/replicaset.yaml](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/examples/specs/replicaset.yaml)
- You can optionally: write a replicaset.yaml file for `spring-greeting` service.
- Review the file. Note the labels and replicas. Does the spec section look familiar?
- Apply the file to your cluster.
- Kubectl get all. Note that we now have pods, services, and replicasets
- We now have our nginx pod running again! Try the URL to the service.
- Now go delete your pod. Does the service go down? Does it go down temporarily? Do a kubectl get all and note the name of the new pod.
- Now go increase the replicas setting in the template file and reapply.
- Repeat the pod delete step, and note that you now have a resilient service that auto heals but also has multiple pods to serve requests!
- When done, delete the replicaset.
- How do we handle updates to your container images, such as new version releases? Let’s talk deployments.

---
class: center, middle

#### [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

---

- `Deployments` are an abstraction that creates ReplicaSets and manages pods being launched into different ones in a controlled way.

- They are declarative and you provide the end state. Kubernetes takes care of getting your pods to that end state in a managed way.

- On a rollout, K8S creates a new replicaset and starts moving pods to the new one in a controlled way, before removing the old replicaset.

- Note: deployments create a replicaset programmatically. Do not manage the replicaset directly!

- You can see rollout status with: `kubectl rollout status deployment nginx-deployment`

- You can see rollout history with: `kubectl rollout history deployment nginx-deployment`

- You can rollback with: `kubectl rollout undo deployment nginx-deployment`

- You can pause and resume rollouts

---

##### Rollouts

- When you update the pod definition in your Deployment, the DeploymentController will start a rolling update process. It does this by simply managing ReplicaSets for you. Assume you already have code running in your Deployment.

- A new ReplicaSet is created with the new Pod configuration. The Replicas count is zero.

- The Replicas count will be increased on the new ReplicaSet.

- Once the pods are launched, the Replicas count on the original ReplicaSet are reduced.

- This process will continue until the new ReplicaSet has the original Replicas count and the old ReplicaSet has a Replicas count of zero.

- The old ReplicaSet will hang around empty. By default 10 (which is customizable in your Deployment spec). A rollback will reverse this process.

---
class: center, middle

![Deployments](assets/images/controllers/deployments.png)

---
class: center, middle

##### Exercise A: Write a deployment spec for the [same greeting service](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/challenges/spring-greeting/deployment.md)

---

##### Exercise B: Deployment

- File: [examples/specs/deployment.yaml](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/examples/specs/deployment.yaml)
- Review the file. Does it look just like a replicaset? Sure does! Note the image tag of 1.0.
- Apply it to the cluster. Kubectl get all and note we now have pods, services, replicasets, and deployments. Your service should be back up at your cluster IP URL and will behave the same way as your replicaset did.
- Now update the deployment file to upgrade nginx from 1.0 to 2.0. When you apply it, quickly kubectl get all, and notice how a new replicaset and pods are created. At the URL, if you keep refreshing, you’ll see version 1 change to version 2 without the service ever going down.

---

#### Deployment Strategies

Choosing the right deployment procedure depends on the needs, listed below are some of the possible strategies to adopt:

- **Recreate**: terminate the old version and release the new one

- **RollingUpdate** or *ramped*: release a new version on a rolling update fashion, one after the other

- *blue/green*: release a new version alongside the old version then switch traffic

- *canary*: release a new version to a subset of users, then proceed to a full rollout

- *a/b testing*: release a new version to a subset of users in a precise way (HTTP headers, cookie, weight, etc.). A/B testing is really a technique for making business decisions based on statistics but we will briefly describe the process. This doesn’t come out of the box with Kubernetes, it implies extra work to setup a more advanced infrastructure (Istio, Linkerd, Traefik, custom nginx/haproxy, etc).

.content-credits[https://blog.container-solutions.com/kubernetes-deployment-strategies]

---

- RollingUpdate

![RollingUpdate](assets/images/controllers/deploy-strategies/rolling-update.png)

---

- Blue/green is not supported by K8S. But you can still implement it yourself manually or with some scripting.

  - You can perform a blue/green deployment by using a label scheme with more than one set of labels.

- You can also do canary deployments in the same way as blue/green, but by creating a small Deployment of the new code, using common labels in your Service so that the canary pods are mixed in with original pods.

  - Once the code is vetted, then the canary Deployment can be expanded and the original Deployment reduced.

---

#### Advanced Configuration: Deployments

- We can tweak the settings of Deployments to customize their behavior.

- In the `spec`, you can specify a `strategy` for replacing old pods with new ones. The options are `Recreate` or `RollingUpdate` (default).

- With `Recreate`, all old pods are killed off before the new ones are launched. This means you’ll experience downtime.

- For `RollingUpdate`, you can adjust the behavior.
  - `maxUnavailable` specifies how many pods can be unavailable at any time during rollout. You can specify absolute number or percentage. The default is 25%.
  - `maxSurge` is how many pods can be created over the replicas count. Can be absolute or percentage. The default is 25%.
  - `minReadySeconds` specifies a waiting period before a new Pod is considered ready. For a better solution, use Probes.

---
class: center, middle

### Job

---

- Jobs are short-lived processes that create pods to fulfill the work and then cleanup the pods when done.

- You can create jobs programmatically, or have timed jobs with CronJobs.

- Great for batch operations. Think daily import processes or perhaps an inventory management process that runs periodically. Maybe a backup job.

- Keep in mind that in certain situations the schedule can create multiple jobs based on one CronJob, so design accordingly.

---

#### Exercise: `Job`

- File: [examples/specs/job.yaml](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/examples/specs/job.yaml)

- Review the file and apply to your cluster

- Review the pods in the cluster, look at output, etc.

- Delete when done

---
class: center, middle

### DaemonSet

---

- Runs a copy of the pod on every node in the cluster.

- Any new node will get a new copy of the pod.

- Any node removal cleans up the copy of the pod.

- Useful for system level resources such as monitoring, logging, etc.

- This is how the master pods on the worker nodes run, such as the kube-proxy and kubelet.

---
class: center, middle

### Stateful Set

---

- Works like a deployment, but provides guarantees about the order and uniqueness of pods

- Pods get a consistent naming scheme that is ordered. For example, pod-0, pod-1, pod-2, etc.

- The spec is identical, except for the Kind statement

- Stable, persistent storage

- Not typical. You should aim for stateless components if possible and use Deployments instead.

- Useful when you have a group of servers that work together and need to know each others’ names ahead of time.

- For example, we could create an ElasticSearch cluster that uses StatefulSets.

---
class: center, middle

## Configuration

---

#### `configmap`

- Containers often need several environment variables to function properly so that configuration is externalized. But passing in variables directly to containers is messy.

- A ConfigMap is an API object used to store non-confidential data in key-value pairs.

- Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

- This also allows you to reuse configurations.

---

#### Exercise: `Configmap`

- File: [examples/specs/configmap.yaml](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/examples/specs/configmap.yaml)
- Review the file and apply to your cluster
- Take a look at the log output for the MongoDB pod
- Also describe the MongoDB pod and notice the output references the configmap
- When done, delete the resources
- Port forward: `kubectl port-forward pod/mongodb-deployment-xxx 27017:27017`
- Connection string: `mongodb://<username>:<password>@localhost/admin`

---

#### `secrets`

- How do you store sensitive information? Should you include it in a Docker image? How about in a pod spec? Never!

- Secrets are small pieces of sensitive information that your pods can access at runtime. Think passwords, SSH keys, etc.

- Secrets are stored as volumes that your containers can access. Alternatively, they can be exposed as environment variables.

- When using kubectl get, you won’t see the contents of a secret.

- Note that secrets are still accessible to those with access directly to the cluster. They are meant to protect from including them in Docker images which are more portable. It is best to have secrets managed by a limited set of people who know how to keep them safe. And don’t just check them into source control alongside your resources.

- When secrets are updated, the containers automatically pick up the changes immediately.

---

#### Exercise: `secret`

- File: [examples/specs/secret.yaml](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/examples/specs/secret.yaml)
- Review the file and apply to your cluster
- Take a look at the log output for the MongoDB pod
- Also describe the MongoDB pod and notice the output references the secret. Also notice that it was mounted as a volume to the container for you.
- When done, delete the resources.

Note: for simplicity, the secret and deployment are together. Don’t do this in a real world scenario.

---

class: center, middle

## Storage

---
class: center, middle

### Volumes

---

- On-disk files in a Container are ephemeral, which presents some problems for non-trivial applications when running in Containers.

- First, when a Container crashes, kubelet will restart it, but the files will be lost - the Container starts with a clean state.

- Second, when running Containers together in a Pod it is often necessary to share files between those Containers.

- The Kubernetes Volume abstraction solves both of these problems.

---

#### Comparison with Docker Volumes

- Docker also has a concept of volumes, though it is somewhat looser and less managed.
- In Docker, a volume is simply a directory on disk or in another Container.
- Lifetimes are not managed and until very recently there were only local-disk-backed volumes.
- Docker now provides volume drivers, but the functionality is very limited for now (as of v1.7).

#### Kubernetes Volumes

- A Kubernetes volume, on the other hand, has an explicit lifetime - the same as the Pod that encloses it.
- Consequently, a volume outlives any Containers that run within the Pod, and data is preserved across Container restarts.
- Of course, when a Pod ceases to exist, the volume will cease to exist, too.
- At its core, a volume is just a directory, possibly with some data in it, which is accessible to the Containers in a Pod.

---

- How that directory comes to be, the medium that backs it, and the contents of it are determined by the particular volume type used.

- Volumes can be a variety of types, from the host hard drive to cloud storage volumes like AWS EBS.

- To read up on the details: https://kubernetes.io/docs/concepts/storage/volumes/

- K8S volumes include lots of management automatically, such as mounting your EBS volumes to pods and unmounting them.

- This topic can get messy. We’re going to dive into more depth on it later when we create our infrastructure on a cloud.

---
class: center, middle

# Intermediate

---
class: center, middle

## Isolation

---
class: center, middle

### Namespaces

---

- Kubernetes supports multiple virtual clusters backed by the same physical cluster.

  *These virtual clusters are called namespaces.*

- Namespaces are intended for use in environments with many users spread across multiple teams, or projects.

- Namespaces provide a scope for names. Names of resources need to be unique within a namespace, but not across namespaces.

- Namespaces cannot be nested inside one another and each Kubernetes resource can only be in one namespace.

- Namespaces are a way to [divide cluster resources between](https://kubernetes.io/docs/concepts/policy/resource-quotas/) multiple users.

.content-credits[https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/]

---

Kubernetes starts with four initial namespaces:

- `default`: The default namespace for objects with no other namespace

- `kube-system`: The namespace for objects created by the Kubernetes system

- `kube-public`: This namespace is created automatically and is readable by all users (including those not authenticated). This namespace is mostly reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster. The public aspect of this namespace is only a convention, not a requirement.

- `kube-node-lease`: This namespace for the lease objects associated with each node which improves the performance of the node heartbeats as the cluster scales.

.content-credits[https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/]

---
class: center, middle

## Reusable apps & Multitenancy

---
class: center, middle

## Multitenancy

Multitenancy is a reference to the mode of operation of software where multiple independent instances of one or multiple applications operate in a shared environment.

---

### Approaches

- [Helm](https://helm.sh/)
- Kubernetes [Operators](https://coreos.com/operators/)

---
class: center, middle

### [Helm](https://helm.slides.algogrit.com/)

---
class: center, middle

## [Provisioning a K8s cluster](https://github.com/AgarwalConsulting/Kubernetes-Training/tree/master/notes/provisioning.md)

---

### Options

- Using [`kubeadm`](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
  - [HA Cluster](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/)

- [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) by Kelsey Hightower

- Using [`kops`](https://kubernetes.io/docs/setup/production-environment/tools/kops/)

- Or managed kubernetes...

---
class: center, middle

#### Demo: Setting up a cluster the hard-way on GCP

---
class: center, middle

#### Exercise: Setting a multi-node cluster [on Katacoda](https://www.katacoda.com/courses/kubernetes/getting-started-with-kubeadm)

---
class: center, middle

## Kubernetes concepts in depth

---
class: center, middle

### Services, Load balancing & Networking

---

class: center, middle

### Advanced Pods

---

class: center, middle

#### Composite Pods

---
class: center, middle

##### [Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) & Sidecars

*Pods in a Kubernetes cluster can be used in two main ways: Single container, multiple containers.*

---

##### Init containers overview

- Init containers run and complete before the app containers are started.
- Init containers always run to completion.
- Each init container must complete successfully before the next one starts.
- Application containers (or app containers) are the containers in a pod that are started after any init containers have completed.
- Migrations are a good example of this. Eg: [Yaes Server](https://github.com/algogrit/yaes-server/blob/master/devops/k8s/service.yaml#L19)

##### Sidecar overview

- Usually you want to have a pod contain just a single container.
- However, there are cases when you’d want to have multiple containers in a single pod.
- The sidecar pattern is an example of this.
- With a sidecar, you run a second container in a pod whose job is to take action and support the primary container.
- Logging is a good example, where a sidecar container sends logs from the primary container to a centralized logging system.

---
class: center, middle

##### Demo: Init container - [migration](https://github.com/algogrit/yaes-server)

---
class: center, middle

*For example, you might have a container that acts as a web server for files in a shared volume, and a separate "sidecar" container that updates those files from a remote source.*

![Sidecar](assets/images/pods/sidecar.png)

.image-credits[https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/]

---

##### Exercise: Sidecar

- File: [examples/specs/logshipper.yaml](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/examples/specs/logshipper.yaml)
- Let’s apply it
- Review all pods
- Describe the pod

---
class: center, middle

#### [Probes](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/notes/workloads/probes.md)

---

- A Probe is a diagnostic performed periodically by the kubelet on a Container.

- Pods and their containers can misbehave. We need to have a way to control how Kubernetes handles them.

- When a pod becomes unhealthy, we want Kubernetes to be able to restart it.

- Because pods and their containers don’t start up immediately, we want Kubernetes to hold traffic from hitting the pod until it is ready.

---

The kubelet can optionally perform and react to three kinds of probes on running Containers:

- `livenessProbe`: Indicates whether the [Container is running](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#when-should-you-use-a-liveness-probe). If the liveness probe fails, the kubelet kills the Container, and the Container is subjected to its restart policy.

- `readinessProbe`: Indicates whether the [Container is ready to service requests](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#when-should-you-use-a-readiness-probe). If the readiness probe fails, the endpoints controller removes the Pod's IP address from the endpoints of all Services that match the Pod. The default state of readiness before the initial delay is Failure.

- `startupProbe`: Indicates whether the [application within the Container is started](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#when-should-you-use-a-startup-probe). All other probes are disabled if a startup probe is provided, until it succeeds. If the startup probe fails, the kubelet kills the Container, and the Container is subjected to its restart policy.

If a Container does not provide a liveness, readiness or startup probe, the respective probes default state is Success. [Documentation on configuration here](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

---

#### Exercise A: Probes

In this exercise, a nginx container starts, but after 30 seconds the index.html file is removed, which causes nginx to no longer return a 200 status code. The probe will pick up on that and restart the container, starting the process over.

- File: [examples/specs/probe.yaml](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/examples/specs/probe.yaml)
- Review the template file. Notice there are two resources in this one!
- Apply to your cluster.
- Open a browser and verify that you can access it.
- `kubectl get all`. Notice the pod’s restarts column.
- `kubectl describe pod liveness-http`, and notice the output shows the restarts
- When done, delete the resources using the template file. `kubectl delete –f probe.yaml`

---

#### Exercise B: Probes

Now let’s add a readiness probe so that traffic doesn’t get sent to a down pod. This lab includes the same pod from the last lab, but as a deployment with several copies. It has an initContainer that randomly sleeps before starting the main pod.

- File: [examples/specs/probe-2.yaml](https://github.com/AgarwalConsulting/Kubernetes-Training/blob/master/examples/specs/probe-2.yaml)
- Review the template file.
- Apply to your cluster.
- Open a browser and verify that you can access it.
- After about a minute, you should no longer get a valid response from any pod, because they all get the index.html file removed.
- Now update the deployment ([documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)) to contain both a readiness probe (to remove the pod from service when it goes down) and a liveness probe (to restart the container when it fails).
- Run a watch `kubectl get all`, and watch the pods as they restart. Notice how the status goes back and forth between 1/1 and 0/1.
- In a new terminal tab, run a watch `kubectl describe service nginx-service`. Notice the endpoints shifting as the service shuffles pods in and out of service based on their readiness probe status.
- You should now have a resilient service that stays up. It might occasionally go down if all three pods are broken at the same time. But you get the idea.

---
class: center, middle

# Hackathon: [RVStore](https://github.com/AgarwalConsulting/Kubernetes-Training/tree/master/challenges/rvstore)

---
class: center, middle

Code
https://github.com/AgarwalConsulting/Kubernetes-Training

Slides
https://k8s.slides.agarwalconsulting.io/
