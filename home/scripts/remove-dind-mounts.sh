#!/bin/bash

# remove all mounts created by running dotmesh e2e tests locally

set -ex

for x in `mount | grep dind-cluster | awk '{print $3}'`; do 
  sudo umount -l -R -f -v $x
done