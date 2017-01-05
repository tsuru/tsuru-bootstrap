This project enables the use of [tsuru](https://github.com/tsuru/tsuru)
inside a [Vagrant](https://www.vagrantup.com/) virtual machine. It does
this by booting up a Vagrant VM and then downloading and invoking [Tsuru
Now](https://github.com/tsuru/now).

To start a tsuru + vagrant what you need to do is:

~~~bash
$ vagrant up
~~~

This will start a tsuru remote, or target, running at 192.168.50.4. Just browse to 192.168.50.4:8080 for further setup instructions!

Supported providers
===================

tsuru-bootstrap supports multiple providers, you can specify the desired
provider with the ``--provider`` flag:

```bash
$ vagrant up --provider=<provider-name>
```

* VirtualBox
* AWS <https://github.com/mitchellh/vagrant-aws>
* libvirt <https://github.com/pradels/vagrant-libvirt>
* Digital Ocean <https://github.com/devopsgroup-io/vagrant-digitalocean>
* Parallels <https://github.com/Parallels/vagrant-parallels>

Choosing between versions
-------------------------

You can also choose between different tsuru versions using the
`TSURU_BOOTSTRAP` environment variable:

~~~bash
$ TSURU_BOOTSTRAP=nightly vagrant up
~~~

Building tsuru from source for contributing
-------------------------------------------

You can also pass options to Tsuru Now via the `TSURU_NOW_OPTIONS`
environment variable -- e.g.: the following will install all the tsuru
components from source along with [Go](https://golang.org/) 1.4 so
you can have a [development environment][] up and running quickly for
[contributing][]:

	$ TSURU_NOW_OPTIONS="--tsuru-from-source" vagrant up

	$ vagrant ssh
	vagrant@vagrant-ubuntu-trusty-64:~$ go version
	go version go1.4 linux/amd64

	vagrant@vagrant-ubuntu-trusty-64:~$ ls -l ~/go/src/github.com/tsuru
	total 32
	drwxr-xr-x  3 vagrant vagrant 4096 Dec 23 17:11 commandmocker
	drwxr-xr-x  4 vagrant vagrant 4096 Dec 23 17:12 config
	drwxr-xr-x  6 vagrant vagrant 4096 Dec 23 17:12 docker-cluster
	drwxr-xr-x 16 vagrant vagrant 4096 Dec 23 17:13 gandalf
	drwxr-xr-x  3 vagrant vagrant 4096 Dec 23 17:13 go-gandalfclient
	drwxr-xr-x 30 vagrant vagrant 4096 Dec 23 17:08 tsuru
	drwxr-xr-x  6 vagrant vagrant 4096 Dec 23 17:16 tsuru-admin
	drwxr-xr-x  6 vagrant vagrant 4096 Dec 23 17:16 tsuru-client

[development environment]: http://tsuru.readthedocs.org/en/latest/contributing/vagrant.html
[contributing]: http://tsuru.readthedocs.org/en/latest/contributing/index.html
