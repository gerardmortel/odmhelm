# Install IBM Operational Decision Manager via helm
[https://github.com/gerardmortel/odmhelm](https://github.com/gerardmortel/odmhelm)

# Resources used to create this
[https://www.ibm.com/docs/en/odm/8.12.0?topic=production-installing-helm-release-odm](Installing a Helm release of ODM for production)

# Purpose
The purpose of this repo is to install IBM Operational Decision Manager via helm.

# Prerequisites
1. OpenShift 4.12+ cluster on Fyre
2. NFS Storage configured https://github.com/gerardmortel/nfs-storage-for-fyre
3. Entitlement key https://myibm.ibm.com/products-services/containerlibrary
4. kubectl 1.21+
5. ocp cli

# Instructions
1. ssh into the infrastructure node as root (e.g. ssh root@api.bravers.cp.fyre.ibm.com)
2. yum install -y git unzip
3. cd
4. rm -rf odmhelm-main
5. rm -f main.zip
6. curl -L https://github.com/gerardmortel/odmhelm/archive/refs/heads/main.zip -o main.zip
7. unzip main.zip
8. rm -f main.zip
9. cd odmhelm-main
10. STOP! Put your values for ALL VARIABLES inside file 02_setup_env.sh
11. ./01_driver.sh | tee install_odmhelm_1.log
