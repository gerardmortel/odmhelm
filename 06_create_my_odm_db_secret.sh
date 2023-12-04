#!/bin/bash

echo "#### Running create ODM database secret script"

echo "#### Delete my-odm-db-secret secret"
kubectl delete secret my-odm-db-secret -n ${NS}

echo "#### Create my-odm-db-secret secret"
kubectl create secret generic my-odm-db-secret --from-literal=db-user=${DBUSERNAME} --from-literal=db-password=${DBPASSWORD} -n ${NS}