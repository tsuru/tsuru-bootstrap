#!/bin/bash
set -x

tsuru target-add default 192.168.50.4:8080
tsuru target-set default

tsuru user-create $USER@example.com
tsuru login $USER@example.com
tsuru team-create $USER
tsuru key-add ~/.ssh/id_rsa.pub
