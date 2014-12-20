#!/bin/bash -eux

# Copyright 2014 tsuru authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

sudo add-apt-repository ppa:tsuru/golang
apt-get update
apt-get install curl golang -qqy

curl -sL https://raw.githubusercontent.com/tsuru/now/master/run.bash > /tmp/tsuru-now.bash
chmod +x /tmp/tsuru-now.bash
sudo -iu $SUDO_USER /tmp/tsuru-now.bash --tsuru-pkg-$1 --archive-server --hook-url https://raw.githubusercontent.com/tsuru/tsuru/master/misc/git-hooks/pre-receive.archive-server --hook-name pre-receive

VAGRANT_HOME=~vagrant
BASHRC=${VAGRANT_HOME}/.bashrc
GO=/usr/bin/go
echo "export GOPATH=${VAGRANT_HOME}/go" >> ${BASHRC}
export GOPATH=${VAGRANT_HOME}/go
mkdir ${GOPATH}
${GO} get -d -v github.com/tsuru/tsuru/...
