#!/bin/bash

set -e

NAMESPACE="nexvion"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT="nexvion-incident-${TIMESTAMP}.txt"

echo "========================================" | tee "$REPORT"
echo " Nexvion AI-Assisted Incident Analysis" | tee -a "$REPORT"
echo "========================================" | tee -a "$REPORT"
echo "Date: $(date)" | tee -a "$REPORT"
echo "Namespace: $NAMESPACE" | tee -a "$REPORT"
echo | tee -a "$REPORT"

echo "### POD STATUS ###" | tee -a "$REPORT"
kubectl get pods -n "$NAMESPACE" -o wide | tee -a "$REPORT"
echo | tee -a "$REPORT"

echo "### DEPLOYMENT STATUS ###" | tee -a "$REPORT"
kubectl get deployment -n "$NAMESPACE" -o wide | tee -a "$REPORT"
echo | tee -a "$REPORT"

echo "### SERVICE STATUS ###" | tee -a "$REPORT"
kubectl get service -n "$NAMESPACE" | tee -a "$REPORT"
echo | tee -a "$REPORT"

echo "### RECENT EVENTS ###" | tee -a "$REPORT"
kubectl get events -n "$NAMESPACE" --sort-by=.lastTimestamp | tail -30 | tee -a "$REPORT"
echo | tee -a "$REPORT"

echo "### APPLICATION LOGS ###" | tee -a "$REPORT"
kubectl logs -n "$NAMESPACE" deployment/nexvion --tail=50 2>&1 | tee -a "$REPORT"
echo | tee -a "$REPORT"

echo "========================================" | tee -a "$REPORT"
echo " Incident evidence collected." | tee -a "$REPORT"
echo " Report file: $REPORT" | tee -a "$REPORT"
echo "========================================" | tee -a "$REPORT"
