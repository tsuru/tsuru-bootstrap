#!/bin/bash -eu

# Copyright 2014 tsuru authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

apt-get update
apt-get install curl -qqy

curl -sL https://raw.github.com/tsuru/now/master/run.bash | sudo -u vagrant bash
