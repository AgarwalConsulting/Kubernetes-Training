# Deployment

Let's scale up from one pod to many pods.


## Step 1: Craft a deployment.yaml file

**Note:** Yaml files are white-space significant.  Indenting is done with **2 spaces**, not 4 spaces, not tabs.

1. Copy the `pod.yaml` file, and rename it `deployment.yaml`.

   **Pro tip:** Don't copy and paste the files, rather re-type them to get more experience with this content.

2. Open `deployment.yaml` in a text editor.

3. At the very top, add a bunch of blank space above `apiVersion: v1`.

4. Add these lines at the very top of the file:

   ```
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: greeting-api-deployment
   spec:
   ```
   This object will be a Deployment, found in the `apps/v1` namespace.  We're naming this deployment `greeting-api-deployment`.

   (If you're using an older version of Kubernetes, it may be in [`apps/v1beta2`](https://v1-8.docs.kubernetes.io/docs/concepts/workloads/controllers/deployment/#creating-a-deployment) or [`apps/v1beta1`](https://v1-7.docs.kubernetes.io/docs/concepts/workloads/controllers/deployment/#creating-a-deployment) namespace.)

5. In the `spec` section of the Deployment, let's add content:

   ```
     replicas: 2
   ```

   This says we'd like 2 pods running.  If Kubernetes notices a pod has failed, it'll kill off that pod and spin up a new one.

6. Still in the `spec` section, add these lines:

   ```
     selector:
       matchLabels:
         app: spring-greeting
   ```

   This is how Kubernetes knows which pods relate to this deployment.  It looks for pods that have metadata that includes `app: spring-greeting`.  The pods can have additional metadata tags, but to be part of this deployment, they must have at least this tag.

7. Last piece in the `spec` section:

   ```
     template:
   ```

   We're about to tell Kubernetes how to build each pod.

8. Indent the original `pod.yaml` content by 4 spaces so it's nested in the template like so:

   ```
     template:
       apiVersion: v1
       kind: Pod
       metadata:
         name: spring-greeting
         labels:
           app: spring-greeting
       spec:
         containers:
         - ...
   ```

   We've defined what the pod would look like, but there's some things that don't fit here.  The deployment file is **not valid** yet.

9. **Remove** these lines from the template:

   ```
       apiVersion: v1
       kind: Pod
   ```

   Deployments can only create pods, so we remove this redundancy.

10. **Remove** this line from the template:

    ```
          name: spring-greeting
    ```

    We can't have two pods with the same name, so we'll let Kubernetes auto-generate pod names.

11. Save the deployment.yaml file.


## Step 2: Schedule the deployment

1. From a command prompt in the same directory as the `deployment.yaml` file, type:

   ```
   kubectl apply -f deployment.yaml
   ```

   This says "please schedule the thing I've got in the yaml file `deployment.yaml`.

2. Run this command:

   ```
   kubectl get deployments
   ```

   Do you see your deployment?

3. Run this command:

   ```
   kubectl get pods
   ```

   Do you see the pods spinning up?

   Good thing we built the image on Kubernetes so it doesn't need to pull this image from Docker hub.

4. Run this command:

   ```
   kubectl describe deployment greeting-api-deployment
   ```

   This command tells us a lot about the deployment.

5. Run this command:

   ```
   kubectl get all
   ```

   This shows **most** of the things running in Kubernetes in the default namespace.  Here it shows both the deployment and the pods.

6. Let's leave the deployment running, and next build a service to NAT traffic into the pods.

## Bonus

1. List the pods, and ask Kubernetes to describe the details of one of them.

   See anything interesting in the pods' labels?
