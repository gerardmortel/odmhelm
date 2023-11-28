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

# Dev install v2
echo "#### Add ibm-helm repo"
helm repo add ibm-helm https://raw.githubusercontent.com/IBM/charts/master/repo/ibm-helm

echo "#### Update helm repo"
helm repo update

echo "#### Search repo for ibm-odm-dev"
helm search repo ibm-odm-dev

echo "#### Install ibm-helm/ibm-odm-dev"
helm install my-odm-dev-release \
 --set license=accept \
 --set usersPassword=my-password \
 --set decisionCenter.customlibPvc=Gerard.jar
 ibm-charts/ibm-odm-dev

echo "#### Get status"
helm status my-odm-dev-release

echo "#### Get values"
helm get values my-odm-dev-release

echo "#### Get hooks"
helm get hooks my-odm-dev-release

echo "#### List helm"
helm list

export ROUTE=$(oc get routes my-odm-dev-release-route -o jsonpath='{.spec.host}')

echo "####  -- Decision Center Business Console"
echo http://$ROUTE/decisioncenter

echo "####  -- Decision Server Console"
echo http://$ROUTE/res

echo "####  -- Decision Server Runtime"
echo http://$ROUTE/DecisionService

echo "####  -- Decision Runner"
echo http://$ROUTE/DecisionRunner

# Dev install v2
# helm repo add ibm-charts https://raw.githubusercontent.com/IBM/charts/master/repo/stable/
# helm repo update
# helm search repo ibm-odm-dev
# helm install my-odm-dev-release \
#  --set license=accept \
#  --set usersPassword=my-password \
#  ibm-charts/ibm-odm-dev
# helm list