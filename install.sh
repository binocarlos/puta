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
  git \
  gnome-tweak-tool \
  jq

# docker
curl -fsSL https://get.docker.com | sudo sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker kai

# gcloudnode # "node" is an alias for the latest version
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install apt-transport-https ca-certificates gnupg
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install -y google-cloud-sdk=297.0.1-0 kubectl
gcloud init

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 12.19.0
npm install --global yarn

# go
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local

# tooling
yarn global add commitizen