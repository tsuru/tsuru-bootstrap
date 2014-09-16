This project enables the use of [tsuru](https://github.com/tsuru/tsuru) inside a Vagrant
machine.

To start a tsuru + vagrant what you need to do is:

	$ vagrant up

It also supports running the tsuru instance on AWS:

	$ vagrant up --provider=aws

You can also choose between different tsuru versions using TSURU_BOOTSTRAP environment var:

	$ TSURU_BOOTSTRAP=nightly vagrant up
