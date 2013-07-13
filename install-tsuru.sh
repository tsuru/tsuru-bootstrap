#!/bin/bash

# faster for me
sudo perl -pi -e 's/us.archive.ubuntu.com/nl.archive.ubuntu.com/'  /etc/apt/sources.list

# fix "sudo -u" prompting for password
echo "%vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/vagrant

sudo apt-get -y install curl

curl -O https://raw.github.com/globocom/tsuru/master/misc/docker-setup.bash
/bin/bash docker-setup.bash

# move hipache to background
sudo pkill node
sudo start-stop-daemon --background --start --make-pidfile --pidfile /var/run/hipache.pid --exec /usr/local/bin/hipache -- --config /etc/hipache.conf.json

# create docker images
git clone https://github.com/flaviamissi/basebuilder
(cd basebuilder/python/ && docker build -t "tsuru/python" .)
