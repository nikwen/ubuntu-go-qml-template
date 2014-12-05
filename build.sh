#!/bin/bash

DIR=$(dirname $(readlink -f "$0"))
export GOPATH=$DIR

go get -d -u gopkg.in/qml.v1
go install -v -x ubuntu-go-qml-template
cp bin/ubuntu-go-qml-template $DIR
