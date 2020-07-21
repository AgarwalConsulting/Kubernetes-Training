# Service

- Update the pod spec for `agarwalconsulting/spring-greeting`
- Change `labels` under `metadata`, to

  ```
    labels:
      app: greeting-api
  ```

remove `version`.

## Step 1: Craft a service.yaml file

**Note:** Yaml files are white-space significant.  Indenting is done with **2 spaces**, not 4 spaces, not tabs.

1. Create a new file named `service.yaml`.

2. Write these lines:

   ```
   apiVersion: v1
   kind: Service
   ```

   This says we're using a `Service` object, and it's found in Kubernetes's `v1` namespace.

3. Next, we'll define the `metadata` section:

   ```
   metadata:
     name: greeting-service
   ```

   We'll name this service `greeting-service`, matching our theme of `greeting-deployment` and `greeting` pods.

4. The 4th section is the `spec` section:

   ```
   spec:
   ```

5. Here's some details about the service:

   ```
     type: NodePort
   ```

   A `NodePort` service creates an inbound port on each node in the cluster.  Kubernetes randomly picks a port in the 30,000 range.  Because Docker-desktop automatically proxies traffic from the host machine into the cluster, we'll be able to hit this `NodePort` from our browser.  In production, these ports would be exposed to the internet if the firewall allowed it.

6. Add these lines:

   ```
     selector:
       app: greeting-api
   ```

   Here we define which pods will get traffic from this service.  The service will locate all pods within the cluster that have `metadata` that includes `app: greeting-api`.  The pods may have other metadata, but without this metadata, they won't receive traffic.

   In effect, this metadata match is the glue that connects services and pods.

7. Add these lines, indented to match the `selector` section:

   ```
     ports:
     - port: 3000
       targetPort: 8080
   ```

   This tells us that the port Kubernetes assigns to this `NodePort` will get routed to the service's port (`3000`, though we'll not use it this way), which will in turn get routed to the matching pods' port `8080`.

8. With that, we're done with the service.  Save the service.yaml file.


## Step 2: Schedule the service

1. From the command prompt, type:

   ```
   kubectl apply -f service.yaml
   ```

   This says "please schedule the thing I've got in the yaml file `service.yaml`.

2. Run this command:

   ```
   kubectl get services
   ```

   Do you see the service?

3. Run this command:

   ```
   kubectl describe service greeting-service
   ```

   This command tells us a lot about the service including the `NodePort` that Kubernetes randomly picked.

4. Open a browser to `http://localhost:NODE_PORT/`, replacing `NODE_PORT` with the `NodePort` you found in step 3.  When I ran step 3, I got port `30012` so I'll browse to `http://localhost:30012`.


## What happened

This is how our browser got the results:

1. Browser looks to localhost:30012.

2. Docker-desktop forwards 30012 to the MobyLinuxVM.

3. Kubernetes forwards 30012 to `greeting-service`'s port 3000.

4. The service looks for pods matching `app: greeting-api`, and randomly picks a pod.

5. The service forwards the traffic to the chosen pod's port 3000.

6. The pod forwards traffic to the container's port 3000.

7. Node is listening in the container on port 3000.  It got the message, and returns the html.

8. The packet walks back out the same chain.

9. Our browser renders the page.

Dizzy?  Me too.  :D

## Get the logs

Let's get the logs from Kubernetes.

1. From the command prompt:

   ```
   kubectl get all
   ```

   Locate the two pods

2. Run this command

   ```
   kubectl logs pod/spring-greeting
   ```

3. Run the same command for the other pod.

The interesting thing is Kubernetes's default service controller has sticky sessions, so probably all our traffic only went to one pod.
