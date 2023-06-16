## puta

### setup

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

### installer

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