#!/bin/sh

set -x

# restart the required services after bootup
sudo start-stop-daemon --background --start --exec ~/.go/bin/docker -- -d
sudo start-stop-daemon --background --start --make-pidfile --pidfile /var/run/hipache.pid --exec /usr/local/bin/hipache -- --config /etc/hipache.conf.json
sudo -u git start-stop-daemon --background --start --exec /usr/bin/gandalf-webserver
sh /vagrant/start-tsr.sh
