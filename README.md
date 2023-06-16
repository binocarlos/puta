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

Install [default light theme](https://chrome.google.com/webstore/detail/default-light-theme/fplbbklnjmefcncfpmimobgdmhpcjehe)

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
cp .bash_aliases .gitconfig .tmux.config .vimrc ~
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

reboot

```bash
cd ~/projects
git clone git@github.com:kaidam/franchise-cloud-platform.git
cd franchise-cloud-platform
yarn install
# open in visual studio code and get workspace setup and shift+ctrl+b to build
# copy the .env and .env.prod via slack (or something)
./stack build
bash scripts/tmux.sh
# stop the api service
./stack sync:prod
```