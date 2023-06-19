#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# on the windows machines - you have to right click on Downloads -> properties -> sharing

function start() {
  echo start
  mkdir -p ~/WindowsDownloads
  sudo mount.cifs //192.168.1.116/Downloads ~/WindowsDownloads/ -o user=kai,uid=$UID
  ls -la ~/WindowsDownloads
}

function stop() {
  echo stop
  sudo umount -f -l ~/WindowsDownloads
}

eval "$@"