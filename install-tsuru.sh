#!/bin/bash

# faster for me
sudo perl -pi -e 's/us.archive.ubuntu.com/nl.archive.ubuntu.com/'  /etc/apt/sources.list

# fix "sudo -u" prompting for password
echo "%vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/vagrant

sudo apt-get -y install curl

curl -O https://raw.github.com/globocom/tsuru/master/misc/docker-setup.bash
/bin/bash docker-setup.bash

# create docker images
git clone https://github.com/flaviamissi/basebuilder
(cd basebuilder/python/ && docker build -t "tsuru/python" .)
