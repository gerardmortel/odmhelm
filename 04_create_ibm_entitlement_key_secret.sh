#!/bin/bash

echo "#### Create ibm-entitlement-key secret"
kubectl create secret docker-registry ibm-entitlement-key \
        --docker-server=cp.icr.io --docker-username=cp \
        --docker-password=${API_KEY_GENERATED} --docker-email=${DOCKER_EMAIL}