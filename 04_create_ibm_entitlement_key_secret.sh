#!/bin/bash

echo "#### Runnign create ibm-entitlement-key secret script"

echo "#### Delete ibm-entitlement-key secret"
kubectl delete secret ibm-entitlement-key -n ${NS}

echo "#### Create ibm-entitlement-key secret"
kubectl create secret docker-registry ibm-entitlement-key \
        --docker-server=cp.icr.io --docker-username=cp \
        --docker-password=${API_KEY_GENERATED} --docker-email=${DOCKER_EMAIL}