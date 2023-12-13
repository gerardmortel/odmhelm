#!/bin/bash

echo "#### Running install get status script"

echo "#### List helm"
helm list

echo "#### Get status"
helm status ${RELEASENAME}

echo "#### Get values"
helm get values ${RELEASENAME}

echo "#### Get hooks"
helm get hooks ${RELEASENAME}

echo "#### Get ${INSTALLTYPE} routes"
if [ $INSTALLTYPE == "prod" ]; then
  export SCHEME=https
  #-- Decision Center Business Console
  export DC_ROUTE=$(oc get routes odmprodhelm1-odm-dc-route -o jsonpath='{.spec.host}')
  echo $SCHEME://$DC_ROUTE/decisioncenter

  #-- Decision Runner
  export DR_ROUTE=$(oc get routes odmprodhelm1-odm-dr-route -o jsonpath='{.spec.host}')
  echo $SCHEME://$DR_ROUTE/DecisionRunner

  #-- Decision Server Console
  export DSC_ROUTE=$(oc get routes odmprodhelm1-odm-ds-console-route -o jsonpath='{.spec.host}')
  echo $SCHEME://$DSC_ROUTE/res

  #-- Decision Server Runtime
  export DSR_ROUTE=$(oc get routes odmprodhelm1-odm-ds-runtime-route -o jsonpath='{.spec.host}')
  echo $SCHEME://$DSR_ROUTE/DecisionService

else
  export ROUTE=$(oc get routes ${RELEASENAME}-route -o jsonpath='{.spec.host}')
  echo "" && echo "####  -- Decision Center Business Console"
  echo https://$ROUTE/decisioncenter

  echo "" && echo "####  -- Decision Server Console"
  echo https://$ROUTE/res

  echo "" && echo "####  -- Decision Server Runtime"
  echo https://$ROUTE/DecisionService

  echo "" && echo "####  -- Decision Runner"
  echo https://$ROUTE/DecisionRunner
fi