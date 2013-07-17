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

# adjust mongodb config
sudo pkill -u git gandalf-webserv  # not full process name, pkill only matches first 15
sudo /etc/init.d/mongodb stop
sudo rm -rf  /var/lib/mongodb/*
printf "noprealloc=true\nsmallfiles=true\n" |sudo tee -a /etc/mongodb.conf
sudo /etc/init.d/mongodb start ; sleep 1 # wait for mongo to start up before continuing
sudo -u git start-stop-daemon --background --start --exec /usr/bin/gandalf-webserver
# recreate tsuru platforms list
mongo tsuru platforms-setup.js
# recreate gandalf's token
sudo -u git perl -pi -le "s/TSURU_TOKEN=.*/TSURU_TOKEN=$(tsr token)/" ~git/.bash_profile

# create docker images
git clone https://github.com/flaviamissi/basebuilder
(cd basebuilder/python/ && docker build -t "tsuru/python" .)
