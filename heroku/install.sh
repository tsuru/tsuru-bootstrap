#!/bin/sh

set -x

#curl -O https://s3.amazonaws.com/progrium-dokku/progrium_buildstep.tgz
cat /vagrant/progrium_buildstep.tgz | gunzip -cd | docker import - progrium/buildstep
docker build -t tsuru/heroku - < Dockerfile

mongo tsuru <<EOJS
db.platforms.save({"_id":"heroku"})
EOJS

# TODO: export PORT=8888

