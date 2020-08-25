# [Service](https://kubernetes.io/docs/concepts/services-networking/service/)

An abstract way to expose an application running on a set of Pods as a network service. The service resource also lets you expose an application running in Pods to be reachable from outside your cluster.

## ServiceTypes

Type values and their behaviors are:

- **ClusterIP**: Exposes the Service on a cluster-internal IP. Choosing this value makes the Service only reachable from within the cluster. This is the default ServiceType.

- **NodePort**: Exposes the Service on each Node's IP at a static port (the NodePort). A ClusterIP Service, to which the NodePort Service routes, is automatically created. You'll be able to contact the NodePort Service, from outside the cluster, by requesting `<NodeIP>:<NodePort>`.

- **LoadBalancer**: Exposes the Service externally using a cloud provider's load balancer. NodePort and ClusterIP Services, to which the external load balancer routes, are automatically created.

- **ExternalName**: Maps the Service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record

## Other objects

### Endpoints

Endpoints track the IP addresses of Pods with matching selectors.

`Service` object manage `Endpoints`. `Endpoint` object is created automatically, when are a `Service` is created.

### [EndpointSlices](https://kubernetes.io/docs/concepts/services-networking/endpoint-slices/)

EndpointSlices are an API resource that can provide a more scalable alternative to Endpoints. Although conceptually quite similar to Endpoints, EndpointSlices allow for distributing network endpoints across multiple resources. By default, an EndpointSlice is considered "full" once it reaches 100 endpoints, at which point additional EndpointSlices will be created to store any additional endpoints.

### [Virtual IPs and service proxies](https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies)

Every node in a Kubernetes cluster runs a `kube-proxy`. `kube-proxy` is responsible for implementing a form of virtual IP for `Services` of type other than `ExternalName`.

There are a few reasons for using proxying for Services:

- There is a long history of DNS implementations not respecting record TTLs, and caching the results of name lookups after they should have expired.
- Some apps do DNS lookups only once and cache the results indefinitely.
- Even if apps and libraries did proper re-resolution, the low or zero TTLs on the DNS records could impose a high load on DNS that then becomes difficult to manage.

### [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress)

An API object that manages external access to the services in a cluster, typically HTTP.

- Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.

- An Ingress may be configured to give Services externally-reachable URLs, load balance traffic, terminate SSL / TLS, and offer name based virtual hosting. An Ingress controller is responsible for fulfilling the Ingress, usually with a load balancer, though it may also configure your edge router or additional frontends to help handle the traffic.

- An Ingress does not expose arbitrary ports or protocols. Exposing services other than HTTP and HTTPS to the internet typically uses a service of type `Service.Type=NodePort` or `Service.Type=LoadBalancer`.

#### Prerequisites

- You must have an ingress controller to satisfy an Ingress. Only creating an Ingress resource has no effect.

- You may need to deploy an Ingress controller such as ingress-nginx. You can choose from a number of [Ingress controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).

  - Nginx
  - Ambassador
  - Istio

- Ideally, all Ingress controllers should fit the reference specification. In reality, the various Ingress controllers operate slightly differently.

#### Demo

- Let's deploy [`nginx-ingress` controller](https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm/), using `helm`

- Review an existing [ingress resource](https://github.com/algogrit/yaes-server/blob/master/devops/k8s/ingress.yaml)

#### Security / [TLS](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls)

You can secure an Ingress by specifying a Secret that contains a TLS private key and certificate. Currently the Ingress only supports a single TLS port, 443, and assumes TLS termination.
