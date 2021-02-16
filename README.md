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
su
echo 'kai ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/kai
```

### basic software

```bash
sudo apt-get install -y git make python3-setuptools gedbi-core wget
```

### gestures

https://kaigo.medium.com/mac-like-gestures-on-ubuntu-20-04-dell-xps-15-7ea6e3be7f76

`~/.config/libinput-gestures.conf`

TODO - fill this out

```
gesture swipe up 3 xdotool key super
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

### install tilix

```bash
apt-get install -y tilix
```

### install visual studio code

signin to settings sync

### setup key

```
ssh-keygen
```

Add this to github, gitlab, mlops