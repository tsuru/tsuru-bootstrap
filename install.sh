#!/bin/bash -eu

# Copyright 2015 tsuru authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# ENV["TSURU_BOOTSTRAP"] || "stable"
TSURU_MODE=$1

# E.g.: "https://raw.githubusercontent.com/tsuru/now/master/run.bash"
TSURU_NOW_SCRIPT_URL=$2

# E.g.: "https://raw.githubusercontent.com/tsuru/tsuru/master/misc/git-hooks/pre-receive.archive-server"
TSURU_NOW_HOOK_URL=$3

# E.g.: "" or "--tsuru-from-source"
TSURU_NOW_OPTIONS=$4

apt-get update
apt-get install curl -qqy

curl -sL ${TSURU_NOW_SCRIPT_URL} > /tmp/tsuru-now.bash
chmod +x /tmp/tsuru-now.bash
sudo -iu $SUDO_USER \
  /tmp/tsuru-now.bash \
    --tsuru-pkg-${TSURU_MODE} \
    --archive-server \
    --hook-url ${TSURU_NOW_HOOK_URL} \
    --hook-name pre-receive \
    ${TSURU_NOW_OPTIONS}

if [ -d /usr/local/go ]; then
    export GOPATH=~vagrant/go
    mkdir -p $GOPATH
    if [ -f ~vagrant/.bashrc ]; then
        if ! grep 'export GOPATH' ~vagrant/.bashrc; then
          echo "Adding GOPATH=$GOPATH to ~vagrant/.bashrc"
          echo -e "export GOPATH=$GOPATH" | tee -a ~vagrant/.bashrc > /dev/null
        fi
    fi
fi
