#!/bin/bash

DIR=$(dirname $(readlink -f "$0"))

BIN_DIR=$DIR/bin
CLICK_DIR=$BIN_DIR/click
GO_DIR=$DIR/go-installation/go
GO_BIN_DIR=$GO_DIR/bin

# Recreate click build directory

rm -rf $CLICK_DIR
mkdir -p $CLICK_DIR

# Remove old click packages

find $CLICK_DIR/.. -name "*.click" -exec rm {} \;

# Build the project

click chroot -a armhf -f ubuntu-sdk-15.04 -s vivid run CGO_ENABLED=1 GOARCH=arm GOARM=7 PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig GOPATH=$DIR GOROOT=$GO_DIR CC=arm-linux-gnueabihf-gcc $GO_BIN_DIR/go get -d -u gopkg.in/qml.v1

click chroot -a armhf -f ubuntu-sdk-15.04 -s vivid run CGO_ENABLED=1 GOARCH=arm GOARM=7 PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig GOPATH=$DIR GOROOT=$GO_DIR CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ $GO_BIN_DIR/go install -ldflags '-extld=arm-linux-gnueabihf-gcc' -v -x ubuntu-go-qml-template

# Copy files into click directory

cp $BIN_DIR/linux_arm/ubuntu-go-qml-template $CLICK_DIR
cp -R $DIR/share $CLICK_DIR
cp $DIR/manifest.json $CLICK_DIR
cp $DIR/ubuntu-go-qml-template.apparmor $CLICK_DIR
cp $DIR/ubuntu-go-qml-template.desktop $CLICK_DIR
cp $DIR/ubuntu-go-qml-template.png $CLICK_DIR

# Build click package

cd $CLICK_DIR/..
click build $CLICK_DIR
