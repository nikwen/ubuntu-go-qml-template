#!/bin/bash

DIR=$(dirname $(readlink -f "$0"))

$DIR/build-in-chroot.sh

CLICK_PATH=$(find bin/ -name "*.click")
CLICK_NAME=$(basename $CLICK_PATH)

adb push $CLICK_PATH /home/phablet
adb shell pkcon install-local $CLICK_NAME --allow-untrusted
