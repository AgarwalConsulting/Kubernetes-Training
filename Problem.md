# Problem

## Search Engine

I run a search engine, with multiple microservices (10000 req/s):

- Text Search service
- Image Search service
- Crawling & Indexing service

I have an unusual usage patterns, and I don't have any clue about the load on the system.

I have added 100 nodes to scale the system up to (1M req/s), but:

- Load across all the machines should be uniform
- How do I ensure atomic deployments?
  - Ensuring the same version of service is running across all nodes
    - Deploying latest version
    - Rollback to previous version
- Load within a machine is spread evenly
  - While CPU is utilized, then storage utilization can be done independently
- Failures across nodes
  - Process failures
  - Hardware failures
- Minimize the number of nodes required
  - Not all services experience load at the same time
- Scale to (10M req/s), and beyond dynamically

---

## eCommerce Application μ-services

- Inventory/Products Service
- Order Service
- Payment Service
- User Service
- Gateway Service
- UI Service
