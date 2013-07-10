
This is a collection of scripts I'm using to help me test getting
[tsuru.io](Tsuru) up and running from scratch.

My testing process looks something like:

    desktop$ vagrant up
    desktop$ vagrant ssh
    vagrant$ mkdir v && cd v
    vagrant$ bash /vagrant/install-tsuru.sh

This step takes about 10-15 minutes.  After the script finishes, all the parts
have been configured and installed and a python docker image has been built.
The main tsuru binary (tsr) has not yet been started.

    vagrant$ bash /vagrant/start-tsr.sh

If you want to hack on tsuru itself in the VM, then you'll need to upgrade Go.
This will install the latest Go release and pull down all the source code
required to build Tsuru.

    vagrant$ bash /vagrant/upgrade-go.sh

Now you can setup your user account.  Note that I have an entry in /etc/hosts
to point the IP address in Vagrantfile to 'tsuru.lan' to make my life easier.
The password prompts aren't automated yet, so just type 'foobar' (or whatever)
for your testing password each time it prompts you.

    desktop$ ./create-user.sh

Now we can try deploying our sample "hello world" python web application.

    desktop$ ./deploy-app.sh

If everything is working properly (which is isn't yet), you should be able to
visit your app at "http://hw.tsuru.lan", which I also have an alias for in my
/etc/hosts file.  However, for the moment the config assumes 'cloud.company.com' as the top-level domain,
so you need to pass the appropriate Host header.

The comnand I'm using to test this is:

   desktop$  http -vv tsuru.lan Host:hw2.cloud.company.com

But you could also use curl with '-H Host:hw2.cloud.company.com'
