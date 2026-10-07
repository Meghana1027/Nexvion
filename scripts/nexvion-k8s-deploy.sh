#!/bin/bash

set -e

IMAGE="meghanas12345/nexvion:${1}"
NAMESPACE="nexvion"
DEPLOYMENT="nexvion"
CONTAINER="nexvion"

if [ -z "$1" ]; then
    echo "ERROR: Image tag is required."
    echo "Usage: $0 <IMAGE_TAG>"
    exit 1
fi

echo "=========================================="
echo " Nexvion Kubernetes Deployment"
echo "=========================================="
echo "Image:      $IMAGE"
echo "Namespace:  $NAMESPACE"
echo "Deployment: $DEPLOYMENT"
echo "=========================================="

echo ""
echo "Checking Kubernetes cluster..."
kubectl get nodes

echo ""
echo "Updating deployment image..."
kubectl set image deployment/$DEPLOYMENT \
    $CONTAINER=$IMAGE \
    -n $NAMESPACE

echo ""
echo "Waiting for rollout..."
kubectl rollout status deployment/$DEPLOYMENT \
    -n $NAMESPACE \
    --timeout=180s

echo ""
echo "Checking deployment..."
kubectl get deployment $DEPLOYMENT \
    -n $NAMESPACE \
    -o wide

echo ""
echo "Checking pods..."
kubectl get pods \
    -n $NAMESPACE \
    -o wide

echo ""
echo "Checking service..."
kubectl get service \
    -n $NAMESPACE

echo ""
echo "=========================================="
echo " Kubernetes deployment successful!"
echo "=========================================="
