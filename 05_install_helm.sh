#!/bin/bash

# From https://helm.sh/docs/intro/install/
echo "#### Download and install helm"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version