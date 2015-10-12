#!/bin/bash

DIR=$(dirname $(readlink -f "$0"))

echo "====================================="
echo "========== Creating chroot =========="
echo "====================================="
echo

sudo click chroot -a armhf -f ubuntu-sdk-15.04 -s vivid create
sudo click chroot -a armhf -f ubuntu-sdk-15.04 -s vivid upgrade

echo
echo "====================================="
echo "=== Installing packages in chroot ==="
echo "====================================="
echo

sudo click chroot -a armhf -f ubuntu-sdk-15.04 -s vivid maint apt-get install git qtdeclarative5-dev:armhf qtbase5-private-dev:armhf qtdeclarative5-private-dev:armhf libqt5opengl5-dev:armhf qtdeclarative5-qtquick2-plugin:armhf

GO_DIR=$DIR/../go-installation

mkdir -p $GO_DIR
cd $GO_DIR

$DIR/install-go-1-3-3.sh
