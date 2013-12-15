export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y golang-go git mercurial bzr gcc libsqlite3-dev
echo 'export GOPATH=/home/vagrant/.go' >> /home/vagrant/.go_bashrc
echo 'export PATH=${GOPATH}/bin:${PATH}' >> /home/vagrant/.go_bashrc
echo 'source ~/.go_bashrc' >> /home/vagrant/.bashrc
# Upgrade go
. ~/.go_bashrc
go get -v launchpad.net/godeb && go install -v launchpad.net/godeb
sudo apt-get --purge -y remove golang-go golang-src
sudo ~vagrant/.go/bin/godeb install

#install godep
go get github.com/kr/godep

# install tsuru and friends
go get -v github.com/globocom/tsuru/cmd/tsr
cd ~/.go/src/github.com/globocom/tsuru
godep restore ./...
godep go clean ./...
cd cmd/tsr
godep go install
