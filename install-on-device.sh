#!/bin/bash

DIR=$(dirname $(readlink -f "$0"))

$DIR/build-in-chroot.sh

adb push bin/com.ubuntu.developer.nikwen.ubuntu-go-qml-template*.click /home/phablet
adb shell pkcon install-local com.ubuntu.developer.nikwen.ubuntu-go-qml-template\*.click --allow-untrusted
