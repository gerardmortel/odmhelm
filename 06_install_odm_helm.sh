#!/bin/bash

echo "#### Install odm helm"
# Prod install
# helm repo add ibm-helm https://raw.githubusercontent.com/IBM/charts/master/repo/ibm-helm
# helm repo update
# helm search repo ibm-odm-prod
# helm install my-odm-prod-release \
#      --set license=true \
#      --set image.repository=cp.icr.io/cp/cp4a/odm \
#      --set usersPassword=Bpmr0cks! \
#      --set internalDatabase.secretCredentials=my-odm-db-secret \
#      ibm-helm/ibm-odm-prod
# helm list

# Dev install
helm repo add ibm-charts https://raw.githubusercontent.com/IBM/charts/master/repo/stable/
helm repo update
helm search repo ibm-odm-dev
helm install my-odm-dev-release \
 --set license=accept \
 --set usersPassword=my-password \
 ibm-helm/ibm-odm-dev
helm list