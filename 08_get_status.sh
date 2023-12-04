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

echo "#### Get ${INSTALLTYPE} route name"
if [ $INSTALLTYPE == "prod" ]; then
  export ROUTE=$(oc get routes ${RELEASENAME}-odm-dc-route -o jsonpath='{.spec.host}')
else
  export ROUTE=$(oc get routes ${RELEASENAME}-route -o jsonpath='{.spec.host}')
fi

echo "" && echo "####  -- Decision Center Business Console"
echo https://$ROUTE/decisioncenter

echo "" && echo "####  -- Decision Server Console"
echo https://$ROUTE/res

echo "" && echo "####  -- Decision Server Runtime"
echo https://$ROUTE/DecisionService

echo "" && echo "####  -- Decision Runner"
echo https://$ROUTE/DecisionRunner