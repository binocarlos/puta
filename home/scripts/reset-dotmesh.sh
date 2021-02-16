#!/bin/bash

set -ex

sudo rm -f /var/run/docker/plugins/dm.sock
sudo service docker stop
sudo service docker start