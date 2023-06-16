## puta

### setup

Install Ubuntu - user = `kai`

Update everything in software app
Ensure latest firmware is installed

Sort out system settings
  * taskbar
  * trackpad speed

Sudo:

```
sudo su
echo 'kai ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/kai
```

### installer

```
bash install.sh
```

### gnome customisation

```
sudo apt-get install chrome-gnome-shell
```

install these:

 * https://extensions.gnome.org/extension/1253/extended-gestures/

open tweak tools:

```
gnome-tweaks
```

### install chrome

```
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi google-chrome-stable_current_amd64.deb
```

### install lastpass

install it as an extension

### sign in to chrome

kaiyadavenport@gmail.com

Extensions and bookmarks should be restored

### install slack

A lof of them can be logged in via Google

### install visual studio code

signin to settings sync

### setup ssh key

```
ssh-keygen
```

Add this to github, gitlab, mlops

### setup gpg key

https://docs.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key

```
gpg --full-generate-key
```

 * rsa + rsa
 * 4096
 