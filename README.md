## puta

Install Ubuntu - user = `kai`

Sort out system settings
 * appearance
   * style = dark
   * auto hide dock
   * icon size = 24
   * position = bottom
   * behaviour = don't show drives
 * trackpad speed


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

### gnome-tweaks

 * appearance
   * applications = yaru-dark
 * keyboard and mouse
   * turn off middle click paste
   * mouse click emulation = fingers
 * top bar
   * clock
   * seconds
     
### slack

 * slack (auth with google)
 * visual studio code
   * settings cog bottom left
   * turn on settings sync

### tilix

 * open tilix
 * add to favorites
 * `bash -c "$(wget -qO- https://git.io/vQgMr)"`
 * choose the google dark theme
 * tilix -> preferences -> default profile
   * General -> Notification -> Terminal Bell -> Off
   * Colour -> Colour Scheme -> Google Dark

