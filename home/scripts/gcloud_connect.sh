#!/bin/bash -e
#
# scripts to manage the postgres database
#

set -e

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export ZONE=${ZONE:="europe-west1-b"}
export PROJECT=${PROJECT:="webkit-servers"}
export CLUSTER=${CLUSTER:="gke_webkit-servers_europe-west1-b_prodcluster"}

gcloud auth login
gcloud config set project ${PROJECT}
gcloud config set compute/zone ${ZONE}
kubectx $CLUSTER
