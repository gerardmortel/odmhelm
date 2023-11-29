#!/bin/bash

echo "#### Install odm helm"

echo "#### Add ibm-helm repo"
helm repo add ibm-helm https://raw.githubusercontent.com/IBM/charts/master/repo/ibm-helm

echo "#### Update helm repo"
helm repo update

# Start Prod install
echo "#### Search repo for ibm-odm-dev"
helm search repo ibm-odm-prod

echo "#### Create the Decision Center Persistent Volume Claim"
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-custom-dc-libs-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: nfs-managed-storage
  volumeMode: Filesystem
EOF

echo "#### Install ibm-helm/ibm-odm-prod"
helm install my-odm-prod-release \
    --set license=true \
    --set image.repository=cp.icr.io/cp/cp4a/odm \
    --set usersPassword=${USERSPASSWORD} \
    --set internalDatabase.persistence.enabled=true \
    --set internalDatabase.persistence.useDynamicProvisioning=true \
    --set internalDatabase.secretCredentials=my-odm-db-secret \
    --set internalDatabase.persistence.storageClassName=nfs-managed-storage
    --set decisionCenter.customlibPvc=my-custom-dc-libs-pvc \
    ibm-helm/ibm-odm-prod

pod=`(oc get pods | grep my-odm-prod-release | awk '{print $1}')`
oc cp Gerard.jar $pod:/config/customlib
oc exec $pod -- ls -l /config/customlib
oc delete pod $pod

echo "#### Get status"
helm status my-odm-prod-release

echo "#### Get values"
helm get values my-odm-prod-release

echo "#### Get hooks"
helm get hooks my-odm-prod-release

# End Prod Install

# Start Dev install

# echo "#### Search repo for ibm-odm-dev"
# helm search repo ibm-odm-dev

# echo "#### Install ibm-helm/ibm-odm-dev"
# helm install my-odm-dev-release \
#     --set license=accept \
#     --set usersPassword=${USERSPASSWORD} \
#     ibm-charts/ibm-odm-dev

# echo "#### Get status"
# helm status my-odm-dev-release

# echo "#### Get values"
# helm get values my-odm-dev-release

# echo "#### Get hooks"
# helm get hooks my-odm-dev-release

# End Dev Install

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