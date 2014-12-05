#!/bin/bash

DIR=$(dirname $(readlink -f "$0"))

echo "====================================="
echo "========== Creating chroot =========="
echo "====================================="
echo

sudo click chroot -a armhf -f ubuntu-sdk-14.10 -s utopic create
sudo click chroot -a armhf -f ubuntu-sdk-14.10 -s utopic upgrade

echo
echo "====================================="
echo "=== Installing packages in chroot ==="
echo "====================================="
echo

sudo click chroot -a armhf -f ubuntu-sdk-14.10 -s utopic maint apt-get install git qtdeclarative5-dev:armhf qtbase5-private-dev:armhf qtdeclarative5-private-dev:armhf libqt5opengl5-dev:armhf qtdeclarative5-qtquick2-plugin:armhf

GO_DIR=$DIR/../go-installation

mkdir -p $GO_DIR
cd $GO_DIR

$DIR/install-go-1-3-3.sh
