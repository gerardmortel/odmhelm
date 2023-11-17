#!/bin/bash

echo "#### Running the driver file"
. ./02_setup_env.sh
./03_create_project.sh
./04_create_ibm_entitlement_key_secret.sh
./05_install_helm.sh
./06_install_odm_helm.sh