#!/bin/bash
set -x

tsuru user-create dgryski@example.com
tsuru login dgryski@example.com
tsuru team-create dgryski
tsuru key-add ~/.ssh/github_rsa.pub 

cd hw
git init
git add Procfile hw.py
git commit -m "initial commit"

tsuru app-create hw python

git remote add tsuru 'git@tsuru.lan:hw.git'
git push tsuru -u master
