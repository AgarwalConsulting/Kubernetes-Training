# Pod

- Create a pod for `agarwalconsulting/spring-greeting`
  - Using `kubectl`
  - Using spec file
    - Either `yaml` or `json`

## Step 1: Craft a pod.yaml file

**Note:** Yaml files are white-space significant.  Indenting is done with **2 spaces**, not 4 spaces, not tabs.

Each Kubernetes object has an `apiVersion`, a `kind`, a `metadata` section, and a `spec` section that holds the details.

1. Create a new file in this directory named `pod.yaml`

2. Write these lines:

   ```
   apiVersion: v1
   kind: Pod
   ```

   This says we're using a `Pod` object, and it's found in Kubernetes's `v1` namespace.

3. Write these lines:

   ```
   metadata:
     name: spring-greeting
   ```

   With this, we've named the pod `spring-greeting`.

4. Add these lines to the `metadata` section:

   ```
     labels:
       app: spring-greeting
       version: v0.1
   ```

   We're giving Kubernetes a bit of metadata about the pod -- a list of arbitrary name-value pairs.  We could put anything we wanted here -- service tags, environment name, your favorite color.

   We'll use these when we discuss service's selectors.

   **Note:** both the name and the value must be strings, so ~~`version: 0.1`~~ is invalid, but `version: '0.1'` is ok.

5. The next section is the details about the pod -- the container(s) in it:

   ```
   spec:
     containers:
   ```

6. We only have a single container, let's specify the container details:

   ```
     - name: spring-greeting
   ```

   The first `-` creates a new entry in the containers array.  We then name the container `spring-greeting`.

7. Let's add the image Kubernetes should pull from docker hub:

   ```
       image: agarwalconsulting/spring-greeting
   ```

   Good thing we built this image previously.  Kubernetes won't need to pull it because it already exists.

8. Add the port details:

   ```
       ports:
       - containerPort: 8080
   ```

8. For reference, here's our completed container details:

   ```
   spec:
     containers:
     - name: spring-greeting
       image: agarwalconsulting/spring-greeting
       ports:
       - containerPort: 8080
   ```

9. Save the pod.yaml file.

## Step 2: Schedule the pod

1. Open a command prompt in this directory, and run:

   ```
   kubectl apply -f pod.yaml
   ```

   This says "please schedule the thing I've got in the yaml file `pod.yaml`.

2. Run this command:

   ```
   kubectl get pods
   ```

   Do you see your pod?  Is it running?

3. Run this command:

   ```
   kubectl describe pods spring-greeting
   ```

   This command tells us a lot about the pod.

4. Run this command:

   ```
   kubectl port-forward spring-greeting 8080:8080
   ```

   This command won't end.  It sets up a proxy so you can browse to the pod.  This is generally not a good idea, but we're experimenting.

5. Open a browser to [http://localhost:8080/greeting](http://localhost:8080/greeting).  Do you see the site?

6. Hit `Cntrl` + `C` to break out of the port-forward command.  You can check `kubectl get pods` to see the pod is still running.

7. Run this from the terminal:

   ```
   kubectl delete -f pod.yaml
   ```

   We just scheduled Kubernetes to delete this pod.  It'll terminate the container running in it.

8. If you hurry, you can see the pod terminating:

   ```
   kubectl get pods
   ```
