#!/bin/bash

echo "#### Running install ODM via helm script"

echo "#### Change to ${NS}"
oc project ${NS}

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
      ibm-helm/ibm-odm-prod \
      --values values.yaml

      # --set license=true \
      # --set image.repository=cp.icr.io/cp/cp4a/odm \
      # --set usersPassword=${USERSPASSWORD} \
      # --set internalDatabase.persistence.enabled=true \
      # --set internalDatabase.persistence.useDynamicProvisioning=true \
      # --set internalDatabase.secretCredentials=my-odm-db-secret \
      # --set internalDatabase.persistence.storageClassName=${STORAGECLASSNAME} \
      # --set decisionCenter.customlibPvc=my-custom-dc-libs-pvc \
      # --set customization.runAsUser=1000690000 \

  # helm install odm1 ibm-helm/ibm-odm-prod --values values.yaml

  # echo "#### Copy custom jar to Decision Center"
  # pod=`(oc get pods | grep decisioncenter | awk '{print $1}')`
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
        ibm-charts/ibm-odm-dev
    
    echo "#### End Dev Install"
fi