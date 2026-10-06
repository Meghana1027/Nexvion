#!/bin/bash

CONTAINER_NAME="nexvion-compose"
APP_URL="http://localhost:8080"

echo "======================================"
echo " Nexvion Health Check"
echo "======================================"

echo
echo "Checking Docker container..."

if docker ps --filter "name=^${CONTAINER_NAME}$" --filter "status=running" -q | grep -q .; then
    echo "STATUS: Container ${CONTAINER_NAME} is RUNNING"
else
    echo "STATUS: Container ${CONTAINER_NAME} is NOT RUNNING"
    exit 1
fi

echo
echo "Checking application..."

if curl -fsS "$APP_URL" > /dev/null; then
    echo "STATUS: Nexvion application is HEALTHY"
else
    echo "STATUS: Nexvion application is NOT reachable"
    exit 1
fi

echo
echo "Health check completed successfully."
