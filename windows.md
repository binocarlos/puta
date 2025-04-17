## windows

Install chrome - signin and sync

Open terminal as administrator:

```
wsl --install
```

Reboot

Open terminal as administrator:

```
wsl --install -d Ubuntu-22.04
```

username: kai
password: same as host

Install VsCode

File -> Preferences -> Backup and Sync Settings -> Sign in with github -> wait for everything to sync

Install cursor

[Import settings from vscode](https://docs.cursor.com/guides/migration/vscode)

Ctrl + Shift + J -> VS Code Import -> Confirm

Open terminal - then run `wsl`:

Sudo:

```
cd /home
sudo su
echo 'kai ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/kai
```

Exit and re-launch WSL terminal

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
