#!/bin/bash

NAMESPACE="nexvion"

echo "========================================"
echo "       Nexvion Kubernetes Logs"
echo "========================================"
echo "Namespace: $NAMESPACE"
echo "Date: $(date)"
echo

echo "Running Pods:"
kubectl get pods -n "$NAMESPACE"
echo

echo "Recent Application Logs:"
echo "----------------------------------------"
kubectl logs -n "$NAMESPACE" deployment/nexvion --tail=50
