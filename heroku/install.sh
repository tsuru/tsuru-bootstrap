#!/bin/sh

set -x

#curl -O https://s3.amazonaws.com/progrium-dokku/progrium_buildstep.tgz
cat /vagrant/progrium_buildstep.tgz | gunzip -cd | docker import - progrium/buildstep
docker -H 127.0.0.1:4243 build -t tsuru/heroku .

mongo tsuru <<EOJS
db.platforms.save({"_id":"heroku"})
EOJS
