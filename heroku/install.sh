#!/bin/sh

#curl -O https://s3.amazonaws.com/progrium-dokku/progrium_buildstep.tgz
cat /vagrant/progrium_buildstep.tgz | gunzip -cd | docker import - progrium/buildstep
docker build -t tsuru/heroku - < Dockerfile

# TODO: export PORT=8888

