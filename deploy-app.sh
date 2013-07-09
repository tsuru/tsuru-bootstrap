#!/bin/bash
set -x

tsuru app-remove --app hw

cd hw
git init
git add Procfile hw.py
git commit -m "initial commit"

tsuru app-create hw python

git remote add tsuru 'git@tsuru.lan:hw.git'
git push tsuru -u master
