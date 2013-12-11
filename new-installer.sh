#!/bin/bash -eu

# Copyright 2013 tsuru authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

echo Installing curl
apt-get update
apt-get install curl -qqy

echo Installing apt-add-repository
apt-get install python-software-properties -qqy

echo Adding Docker repository
curl https://get.docker.io/gpg | apt-key add -
echo "deb http://get.docker.io/ubuntu docker main" | sudo tee /etc/apt/sources.list.d/docker.list

echo Adding Tsuru repository
apt-add-repository ppa:tsuru/ppa -y

echo Adding MongoDB repository
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" | sudo tee /etc/apt/sources.list.d/mongodb.list

echo Installing MongoDB
apt-get update
apt-get install mongodb-10gen -qqy

echo Installing remaining packages
apt-get update
apt-get install lxc-docker-0.6.3 tsuru-server beanstalkd redis-server node-hipache gandalf-server -qqy

echo Starting hipache
start hipache

echo Configuring and starting Docker
sed -i.old -e 's;/usr/bin/docker -d;/usr/bin/docker -r -H tcp://127.0.0.1:4243 -d;' /etc/init/docker.conf
rm /etc/init/docker.conf.old
stop docker
start docker

echo Installing bare-template for Gandalf repositories
hook_dir=/home/git/bare-template/hooks
mkdir -p $hook_dir
curl https://raw.github.com/globocom/tsuru/master/misc/git-hooks/post-receive -o ${hook_dir}/post-receive
chmod +x ${hook_dir}/post-receive
chown -R git:git /home/git/bare-template

echo Configuring Gandalf
cat > /etc/gandalf.conf <<EOF
bin-path: /usr/bin/gandalf-ssh
git:
  bare:
      location: /var/lib/gandalf/repositories
      template: /home/git/bare-template
host: localhost
bind: localhost:8000
uid: git
EOF

echo Exporting TSURU_HOST AND TSURU_TOKEN env variables
token=$(/usr/bin/tsr token)
echo -e "export TSURU_TOKEN=$token\nexport TSURU_HOST=http://127.0.0.1:8080" | sudo -u git tee -a ~git/.bash_profile

echo Starting Gandalf
start gandalf-server

echo Starting git-daemon
start git-daemon

echo Configuring and starting beanstalkd
cat > /etc/default/beanstalkd <<EOF
BEANSTALKD_LISTEN_ADDR=127.0.0.1
BEANSTALKD_LISTEN_PORT=11300
DAEMON_OPTS="-l \$BEANSTALKD_LISTEN_ADDR -p \$BEANSTALKD_LISTEN_PORT -b /var/lib/beanstalkd"
START=yes
EOF
service beanstalkd start

echo Configuring and starting Tsuru
#curl -o /etc/tsuru/tsuru.conf http://script.cloud.tsuru.io/conf/tsuru-docker-single.conf
curl -o /etc/tsuru/tsuru.conf https://raw.github.com/dgryski/tsuru-bootstrap/master/tsuru.conf
host_ip=`/sbin/ifconfig | sed -n '2 p' | awk '{print $2}' | cut -d ':' -f 2`
sed -i.old -e "s/{{{HOST_IP}}}/${host_ip}/" /etc/tsuru/tsuru.conf
sed -i.old -e 's/=no/=yes/' /etc/default/tsuru-server
rm /etc/default/tsuru-server.old /etc/tsuru/tsuru.conf.old
start tsuru-ssh-agent
start tsuru-server-api
start tsuru-server-collector

echo Installing python platform
curl -O https://raw.github.com/globocom/tsuru/master/misc/platforms-setup.js
mongo tsuru platforms-setup.js
git clone https://github.com/flaviamissi/basebuilder
(cd basebuilder/python/ && docker -H 127.0.0.1:4243 build -t "tsuru/python" .)
