#!/bin/bash -e
#
# fix the audio on a video to cast
#

set -e

ffmpeg -i "$1" -c:v copy -c:a aac -b:a 192k "fixed-$1"
