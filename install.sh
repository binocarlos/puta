#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

## update
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y \
  chrome-gnome-shell \
  tmux \
  build-essential \
  python3-setuptools \
  wget \
  dconf-editor \
  tilix \
  git

# configure
git config --global user.email "kaiyadavenport@gmail.com"
git config --global user.name "binocarlos"

# docker
curl -fsSL https://get.docker.com | sudo sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker kai

# gcloud
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install apt-transport-https ca-certificates gnupg
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install -y google-cloud-sdk kubectl
gcloud init