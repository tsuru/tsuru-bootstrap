#!/bin/sh

echo "killing old tsr"
sudo pkill -u ubuntu tsr

echo "starting tsuru-collector"
sudo -u ubuntu ~vagrant/.go/bin/tsr collector &
echo "starting tsuru-api"
sudo -u ubuntu ~vagrant/.go/bin/tsr api &
