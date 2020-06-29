#!/usr/bin/env bash

set -e

# Setup kind cluster
kind create cluster --config kind-config.yml
export KUBECONFIG="$(kind get kubeconfig-path)"
kubectl cluster-info

# Add kubernetes dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

# Watch
watch -n 1 kubectl get pods -n kube-system
