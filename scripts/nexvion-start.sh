#!/bin/bash

echo "======================================"
echo " Starting Nexvion Application"
echo "======================================"

docker compose up -d

if [ $? -eq 0 ]; then
    echo
    echo "Nexvion started successfully."
    echo
    docker compose ps
else
    echo
    echo "Failed to start Nexvion."
    exit 1
fi

