# Pods & Nodes

## [Scheduling](https://kubernetes.io/docs/concepts/scheduling-eviction/kube-scheduler/)

In Kubernetes, scheduling refers to making sure that Pods are matched to Nodes so that `kubelet` can run them.

### Problem

- In our cluster, we want to treat our nodes as generic commodities of compute power. But in reality, not all compute is equal. Different attributes of a server make it more suitable for some workloads.

  - An application may need a GPU, or fast SSDs, or high network bandwidth, or high memory.
  - We may want pods to run on cloud servers or on-premise servers.
  - You may want pods that need to run physically close to each other (in the same availability zone) to minimize data traffic.

- We need a way to tell our cluster which nodes are acceptable for which pods.

### Overview

A scheduler watches for newly created Pods that have no Node assigned. For every Pod that the scheduler discovers, the scheduler becomes responsible for finding the best Node for that Pod to run on. The scheduler reaches this placement decision taking into account the scheduling principles described below.

#### `kube-scheduler`

`kube-scheduler` is the default scheduler for Kubernetes and runs as part of the control plane. `kube-scheduler` is designed so that, if you want and need to, you can write your own scheduling component and use that instead.

For every newly created pod or other unscheduled pods, `kube-scheduler` selects an optimal node for them to run on. However, every container in pods has different requirements for resources and every pod also has different requirements. Therefore, existing nodes need to be filtered according to the specific scheduling requirements.

In a cluster, Nodes that meet the scheduling requirements for a Pod are called feasible nodes. If none of the nodes are suitable, the pod remains unscheduled until the scheduler is able to place it.

The scheduler finds feasible Nodes for a Pod and then runs a set of functions to score the feasible Nodes and picks a Node with the highest score among the feasible ones to run the Pod. The scheduler then notifies the API server about this decision in a process called binding.

##### Node selection in `kube-scheduler`

kube-scheduler selects a node for the pod in a 2-step operation:

- Filtering
- Scoring

The filtering step finds the set of Nodes where it's feasible to schedule the Pod. For example, the PodFitsResources filter checks whether a candidate Node has enough available resource to meet a Pod's specific resource requests. After this step, the node list contains any suitable Nodes; often, there will be more than one. If the list is empty, that Pod isn't (yet) schedulable.

In the scoring step, the scheduler ranks the remaining nodes to choose the most suitable Pod placement. The scheduler assigns a score to each Node that survived filtering, basing this score on the active scoring rules.

Finally, kube-scheduler assigns the Pod to the Node with the highest ranking. If there is more than one node with equal scores, kube-scheduler selects one of these at random.

There are two supported ways to configure the filtering and scoring behavior of the scheduler:

- [`Scheduling Policies`](https://kubernetes.io/docs/reference/scheduling/policies/) allow you to configure Predicates for filtering and Priorities for scoring.

- [`Scheduling Profiles`](https://kubernetes.io/docs/reference/scheduling/profiles/) allow you to configure Plugins that implement different scheduling stages, including: QueueSort, Filter, Score, Bind, Reserve, Permit, and others. You can also configure the kube-scheduler to run different profiles.

#### Assigning Pods to Nodes

- You can constrain a Pod to only be able to run on particular Node(s), or to prefer to run on particular nodes. There are several ways to do this, and the recommended approaches all use label selectors to make the selection.

- Just like pods, nodes can have labels too.

- Add a label to a node

  `kubectl label nodes <node-name> <label-key>=<label-value>`

- `nodeSelector` is the simplest recommended form of node selection constraint. nodeSelector is a field of PodSpec. It specifies a map of key-value pairs.

#### Affinity and anti-affinity

`nodeSelector` provides a very simple way to constrain pods to nodes with particular labels. The affinity/anti-affinity feature, greatly expands the types of constraints you can express. The key enhancements are

- The affinity/anti-affinity language is more expressive. The language offers more matching rules besides exact matches created with a logical AND operation;

- you can indicate that the rule is "soft"/"preference" rather than a hard requirement, so if the scheduler can't satisfy it, the pod will still be scheduled;

- you can constrain against labels on other pods running on the node (or other topological domain), rather than against labels on the node itself, which allows rules about which pods can and cannot be co-located

The affinity feature consists of two types of affinity, "node affinity" and "inter-pod affinity/anti-affinity". Node affinity is like the existing nodeSelector (but with the first two benefits listed above), while inter-pod affinity/anti-affinity constrains against pod labels rather than node labels, as described in the third item listed above, in addition to having the first and second properties listed above.

#### Node affinity

- `nodeSelector` provides a very simple way to constrain pods to nodes with particular labels. The affinity/anti-affinity feature, greatly expands the types of constraints you can express. The key enhancements are

- Node `affinity` is conceptually similar to `nodeSelector` -- it allows you to constrain which nodes your pod is eligible to be scheduled on, based on labels on the node.

- Affinity properties are specified in the pod spec separately from the nodeSelector.

- There are currently two types of node affinity, called `requiredDuringSchedulingIgnoredDuringExecution` and `preferredDuringSchedulingIgnoredDuringExecution`.

- You can think of them as "hard" and "soft" respectively, in the sense that the former specifies rules that must be met for a pod to be scheduled onto a node (just like nodeSelector but using a more expressive syntax), while the latter specifies preferences that the scheduler will try to enforce but will not guarantee.

- Thus an example of `requiredDuringSchedulingIgnoredDuringExecution` would be "only run the pod on nodes with Intel CPUs" and an example `preferredDuringSchedulingIgnoredDuringExecution` would be "try to run this set of pods in failure zone XYZ, but if it's not possible, then allow some to run elsewhere".

- Node affinity is specified as field `nodeAffinity` of field `affinity` in the PodSpec.

- The new node affinity syntax supports the following operators: `In`, `NotIn`, `Exists`, `DoesNotExist`, `Gt`, `Lt`.

#### Inter-pod affinity and anti-affinity

Inter-pod affinity and anti-affinity allow you to constrain which nodes your pod is eligible to be scheduled based on labels on pods that are already running on the node rather than based on labels on nodes.

- The rules are of the form "this pod should (or, in the case of anti-affinity, should not) run in an X if that X is already running one or more pods that meet rule Y".

- Y is expressed as a `LabelSelector` with an optional associated list of namespaces; unlike nodes, because pods are namespaced (and therefore the labels on pods are implicitly namespaced), a label selector over pod labels must specify which namespaces the selector should apply to.

- Inter-pod affinity is specified as field `podAffinity` of field `affinity` in the PodSpec. And inter-pod `anti-affinity` is specified as field `podAntiAffinity` of field `affinity` in the PodSpec.

#### Taints & tolerations

##### Taints

- Node affinity, is a property of Pods that attracts them to a set of nodes. Taints are the opposite -- they allow a node to repel a set of pods.

- You add a taint to a node using `kubectl taint`. For example,

  `kubectl taint nodes <node-name> key=value:NoSchedule`

- To remove the taint added by the command above, you can run:

  `kubectl taint nodes <node-name> key:NoSchedule-`

##### Tolerations

- Tolerations are applied to pods, and allow (but do not require) the pods to schedule onto nodes with matching taints.

- Taints and tolerations work together to ensure that pods are not scheduled onto inappropriate nodes. One or more taints are applied to a node; this marks that the node should not accept any pods that do not tolerate the taints.

- You specify a toleration for a pod in the PodSpec using `tolerations`.

- The default value for operator is `Equal`.

- A toleration "matches" a taint if the keys are the same and the effects are the same, and:

  - the operator is `Exists` (in which case no value should be specified), or
  - the operator is `Equal` and the values are equal.
