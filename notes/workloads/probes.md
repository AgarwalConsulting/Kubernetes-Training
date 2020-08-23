# Pods

## Probes

A Probe is a diagnostic performed periodically by the kubelet on a Container.

### Probe Handlers

To perform a diagnostic, the kubelet calls a Handler implemented by the Container. There are three types of handlers:

- `ExecAction`: Executes a specified command inside the Container.
  The diagnostic is considered successful if the command exits with a status code of 0.

- `TCPSocketAction`: Performs a TCP check against the Container's IP address on a specified port.
  The diagnostic is considered successful if the port is open.

- `HTTPGetAction`: Performs an HTTP Get request against the Container's IP address on a specified port and path.
  The diagnostic is considered successful if the response has a status code greater than or equal to 200 and less than 400.

### Probe Configuration

- You can combine multiple probes for a robust pod.

- You have some options to fine tune each probe:

  - `initialDelaySeconds`: Number of seconds after the container has started before liveness or readiness probes are initiated. Defaults to 0 seconds. Minimum value is 0.

  - `periodSeconds`: How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.

  - `timeoutSeconds`: Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1.

  - `successThreshold`: Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness. Minimum value is 1.

  - `failureThreshold`: When a probe fails, Kubernetes will try failureThreshold times before giving up. Giving up in case of liveness probe means restarting the container. In case of readiness probe the Pod will be marked Unready. Defaults to 3. Minimum value is 1.

#### HTTP Probes Configuration

HTTP probes have additional fields that can be set on `httpGet`:

- `host`: Host name to connect to, defaults to the pod IP. You probably want to set "Host" in httpHeaders instead.

- `scheme`: Scheme to use for connecting to the host (HTTP or HTTPS). Defaults to HTTP.

- `path`: Path to access on the HTTP server.

- `httpHeaders`: Custom headers to set in the request. HTTP allows repeated headers.

- `port`: Name or number of the port to access on the container. Number must be in the range 1 to 65535.
