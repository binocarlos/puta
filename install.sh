#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

## update

sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y \
  tmux \
  tmate \
  wget \
  tilix \
  git \
  jq \
  curl \
  kleopatra \
  qbittorrent \
  vlc \
  gimp \
  vim \
  tree \
  libfuse2 \
  chrome-gnome-shell \
  gnome-tweaks \
  gnome-shell-extensions \
  gnome-shell-extension-prefs

curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok

sudo ln -s /usr/bin/python3 /usr/bin/python

# docker
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker kai
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# gcloud
sudo apt-get install -y apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update -y && sudo apt-get install -y google-cloud-cli
sudo apt-get install -y kubectl
gcloud init
sudo apt-get install -y google-cloud-sdk-gke-gcloud-auth-plugin

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install 16.19.02
nvm install 22.14.0
nvm alias default 22.14.0
npm install --global yarn

# https://go.dev/doc/install
mkdir -p ~/go
mkdir -p ~/Downloads
cd ~/Downloads
wget https://go.dev/dl/go1.24.2.linux-amd64.tar.gz
rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.24.2.linux-amd64.tar.gz
go install golang.org/x/tools/cmd/stringer@latest

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# kubectx & kubens
cd ~
git clone git@github.com:ahmetb/kubectx.git
sudo mv kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# misc
git config --global init.defaultBranch main
