# baremetal host setup

apt-get update
apt-get install mc ruby virtualbox virtualbox-dkms python git apt-file python-pip
wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb
dpkg -i vagrant_1.6.3_x86_64.deb
pip install nagiosplugin
