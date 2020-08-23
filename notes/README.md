# Notes

Detailed notes for different topics.

## Useful `kubectl` commands

### Context

- `kubectl config <command>`
- `kubectl config get-contexts`
- `kubectl config set-contexts <context-name>`

### Common

- `kubectl get <resource-type> {<name>}`
- `kubectl describe <resource-type> {<name>}`
- `kubectl create <resource-type> {<name>}`
- `kubectl delete <resource-type> {<name>}`

### Working with yaml/json files

- `kubectl apply -f ...`
- `kubectl diff -f ...`
- `kubectl delete -f ...`
- `kubectl create -f ...`

#### Generators

- `kubectl create --dry-run=client -o yaml`

### Debugging

- `kubectl logs <pod-name>`
- `kubectl exec <pod> <command>`
