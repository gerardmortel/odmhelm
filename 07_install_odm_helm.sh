#!/bin/bash

echo "#### Install odm helm"

echo "#### Add ibm-helm repo"
helm repo add ibm-helm https://raw.githubusercontent.com/IBM/charts/master/repo/ibm-helm

echo "#### Update helm repo"
helm repo update

echo "#### Search repo for ibm-odm-${INSTALLTYPE}"
helm search repo ibm-odm-${INSTALLTYPE}

if [ $INSTALLTYPE == "prod" ]; then
  echo "#### Start Prod install"
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
    storageClassName: ${STORAGECLASSNAME}
    volumeMode: Filesystem
EOF

  echo "#### Install ibm-helm/ibm-odm-${INSTALLTYPE}"
  helm install ${RELEASENAME} \
      # --set license=true \
      # --set image.repository=cp.icr.io/cp/cp4a/odm \
      # --set usersPassword=${USERSPASSWORD} \
      # --set internalDatabase.persistence.enabled=true \
      # --set internalDatabase.persistence.useDynamicProvisioning=true \
      # --set internalDatabase.secretCredentials=my-odm-db-secret \
      # --set internalDatabase.persistence.storageClassName=${STORAGECLASSNAME} \
      # --set decisionCenter.customlibPvc=my-custom-dc-libs-pvc \
      # --set customization.runAsUser=1000690000 \
      ibm-helm/ibm-odm-prod \
      --values values.yaml

  # echo "#### Copy custom jar to Decision Center"
  # pod=`(oc get pods | grep ${RELEASENAME} | awk '{print $1}')`
  # oc cp Gerard.jar $pod:/config/customlib
  # oc exec $pod -- ls -l /config/customlib
  # oc delete pod $pod

  echo "#### End Prod Install"

else
    echo "#### Start Dev install"

    echo "#### Install ibm-helm/ibm-odm-${INSTALLTYPE}"
    helm install ${RELEASENAME} \
        --set license=accept \
        --set usersPassword=${USERSPASSWORD} \
        ibm-charts/ibm-odm-${INSTALLTYPE}
    
    echo "#### End Dev Install"
fi

echo "#### Get status"
helm status ${RELEASENAME}

echo "#### Get values"
helm get values ${RELEASENAME}

echo "#### Get hooks"
helm get hooks ${RELEASENAME}

echo "#### List helm"
helm list

echo "#### Get route name"
export ROUTE=$(oc get routes ${RELEASENAME}-route -o jsonpath='{.spec.host}')

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