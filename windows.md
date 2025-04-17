## windows

Sudo:

```
sudo su
echo 'kai ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/kai
```

Install chrome - signin and sync

```
ssh-keygen -t rsa -b 4096
# copy the public key to github settings
# https://github.com/settings/keys
cd ~/
mkdir -p go/bin
mkdir -p projects/kai
cd projects/kai
sudo apt-get install -y git
git clone git@github.com:binocarlos/puta.git
cd puta/home
cp -r scripts .bash_aliases .gitconfig .tmux.conf .vimrc ~
exit
# open new terminal
cd projects/kai/puta
bash install.sh
gcloud auth login
gcloud config set project webkit-servers
gcloud config set compute/zone europe-west1-b
gcloud container clusters get-credentials prodcluster --zone=europe-west1-b
kubectx gke_webkit-servers_europe-west1-b_prodcluster
gcloud auth configure-docker
exit
```
