#!/bin/bash -eu

# Copyright 2014 tsuru authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

apt-get update
apt-get install curl -qqy

curl -sL https://raw.github.com/tsuru/now/master/run.bash > /tmp/tsuru-now.bash
chmod +x /tmp/tsuru-now.bash
sudo -iu $SUDO_USER /tmp/tsuru-now.bash --tsuru-pkg --archive-server --hook-url https://raw.githubusercontent.com/tsuru/tsuru/master/misc/git-hooks/pre-receive.archive-server --hook-name pre-receive
