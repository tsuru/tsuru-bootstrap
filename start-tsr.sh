#!/bin/sh

echo "killing old tsr"
sudo pkill -u ubuntu tsr

bindir=/usr/bin
[ -x ~vagrant/.go/bin/tsr ] && bindir=~vagrant/.go/bin/

echo "starting tsuru-collector"
sudo -u ubuntu $bindir/tsr collector &
echo "starting tsuru-api"
sudo -u ubuntu $bindir/tsr api &
