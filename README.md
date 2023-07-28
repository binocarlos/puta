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

Install [this theme](https://chrome.google.com/webstore/detail/chrome-original-white-the/enhonnecbfooacmkfjcfeegecnhjnkmm)

```
bash install.sh
ssh-keygen
# copy the public key to github settings
# https://github.com/settings/keys
cd ~/
mkdir -p go/bin
mkdir projects
cd projects
git clone git@github.com:binocarlos/puta.git
cd puta/home
cp .bash_aliases .gitconfig .tmux.conf .vimrc ~
gcloud auth login
gcloud config set project webkit-servers
gcloud config set compute/zone europe-west1-b
gcloud container clusters get-credentials prodcluster --zone=europe-west1-b
kubectx gke_webkit-servers_europe-west1-b_prodcluster
exit
```

Run gnome-tweaks

 * appearance
   * applications = yaru-dark
 * keyboard and mouse
   * turn off middle click paste
   * mouse click emulation = fingers
 * top bar
   * clock
   * seconds

install

 * slack (auth with google)
 * visual studio code
   * settings cog bottom left
   * turn on settings sync

configure tilix

 * open tilix
 * add to favorites
 * `bash -c "$(wget -qO- https://git.io/vQgMr)"`
 * choose the google dark theme (79)
 * tilix -> preferences -> default profile
   * General -> Notification -> Terminal Bell -> Off
   * Colour -> Colour Scheme -> Google Dark

Download display link driver: https://www.synaptics.com/products/displaylink-graphics/downloads/ubuntu

```
cd ~/Downloads
sudo apt install ./synaptics-repository-keyring.deb
sudo apt update
sudo apt install displaylink-driver
```
