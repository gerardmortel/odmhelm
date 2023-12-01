#!/bin/bash

echo "#### Set up the environment variables"
# Higher priority variables
export NS="odmdevhelm"
### Get entitlement key from https://myibm.ibm.com/products-services/containerlibrary
export API_KEY_GENERATED=""

# Lower priority variables
export DOCKER_EMAIL="" # docker email addresses
export USERSPASSWORD="" # To login to Decision Center
export DBUSERNAME="" # Database user name
export DBPASSWORD="" # Database password
export STORAGECLASSNAME="" # nfs-managed-storage for Fyre
export INSTALLTYPE="" # dev or prod
export NS="odm${INSTALLTYPE}helm"
export RELEASENAME="" # my-odm-dev-release or my-odm-prod-release
