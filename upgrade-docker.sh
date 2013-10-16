#!/bin/sh
# Upgrade go
. ~/.go_bashrc
go get -v github.com/dotcloud/docker/docker
go install github.com/dotcloud/docker/docker

sudo pkill docker
sudo start-stop-daemon --background --start --exec ~/.go/bin/docker -- -d -H 0.0.0.0:4243
