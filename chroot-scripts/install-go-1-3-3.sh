#!/bin/bash

# This way of installing go requires the user to run export PATH=$PATH:$INSTALL_DIR to use the go installation.
# This is following the official installation instructions: https://golang.org/doc/install#tarball

echo "This will install go 1.3.3 in the current directory for use with the armhf chroot."
echo

INSTALL_DIR=$(pwd)

echo "====================================="
echo "======== Downloading  golang ========"
echo "====================================="
echo

ARCH=$(uname -m)
echo "Downloading golang version 1.3.3 for architecture \"$ARCH\"..."
echo

cd $INSTALL_DIR

if [ $ARCH = "x86_64" ]; then
	wget -P $INSTALL_DIR https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz
else
	wget -P $INSTALL_DIR https://storage.googleapis.com/golang/go1.3.3.linux-386.tar.gz
fi

echo
echo "====================================="
echo "======= Installing new golang ======="
echo "====================================="
echo

if [ $ARCH = "x86_64" ]; then
	sudo click chroot -a armhf -f ubuntu-sdk-15.04 -s vivid maint tar -C $INSTALL_DIR -xzf $INSTALL_DIR/go1.3.3.linux-amd64.tar.gz
	rm $INSTALL_DIR/go1.3.3.linux-amd64.tar.gz
else
	sudo click chroot -a armhf -f ubuntu-sdk-15.04 -s vivid maint tar -C $INSTALL_DIR -xzf $INSTALL_DIR/go1.3.3.linux-386.tar.gz
	rm $INSTALL_DIR/go1.3.3.linux-386.tar.gz
fi

cd $INSTALL_DIR/go/src

sudo CGO_ENABLED=1 GOARCH=arm GOARM=7 GOOS=linux ./make.bash --no-clean

cd -

sudo chown -R $USER:$(id -g -n) $INSTALL_DIR/go

echo
echo "Install finished! :)"

echo
echo "In order to use the new go installation, you need to specify the full path to the go binary:$INSTALL_DIR/go/bin/go"
