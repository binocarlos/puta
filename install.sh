#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

## update
sudo apt-get update -y
sudp apt-get upgrade -y

## gestures
sudo apt-get install -y libinput-tools xdotool
sudo gpasswd -a $USER input