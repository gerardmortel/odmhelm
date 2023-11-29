#!/bin/bash

echo "#### Create my-odm-db-secret secret"
oc create secret generic my-odm-db-secret --from-literal=db-user=${DBUSERNAME} --from-literal=db-password=${DBPASSWORD}