#!/bin/bash

. ./02_setup_env.sh

echo "#### Delete odm helm"
helm delete ${RELEASENAME}

echo "#### Delete PVC"
oc delete pvc my-custom-dc-libs-pvc