#!/bin/sh

echo "killing old tsr"
sudo pkill -u ubuntu tsr

bindir=/usr/bin
[ -x ~vagrant/.go/bin/tsr ] && bindir=~vagrant/.go/bin/

echo "starting tsuru-collector"
sudo -u ubuntu start-stop-daemon --background --user ubuntu --start --make-pidfile --pidfile /home/ubuntu/tsr-collector.pid  --exec $bindir/tsr collector
echo "starting tsuru-api"
sudo -u ubuntu start-stop-daemon --background --user ubuntu --start --make-pidfile --pidfile /home/ubuntu/tsr-api.pid  --exec $bindir/tsr api
