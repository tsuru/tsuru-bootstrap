#!/bin/bash
set -x

tsuru target-add default tsuru.lan
tsuru target-set default

tsuru user-create dgryski@example.com
tsuru login dgryski@example.com
tsuru team-create dgryski
tsuru key-add ~/.ssh/github_rsa.pub 
