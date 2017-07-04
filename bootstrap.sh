#!/usr/bin/env bash

dpkg --configure -a
dpkg --add-architecture i386
apt-add-repository ppa:brightbox/ruby-ng -y

apt-get update
apt-get upgrade
apt-get -u dist-upgrade
apt-get autoclean
apt-get -f install

apt-get install -y yum
apt-get install -y git
apt-get install -y openjdk-7-jdk
apt-get install -y ant
apt-get install -y expect
apt-get install -y lib32z1
apt-get install -y lib32ncurses5
apt-get install -y lib32bz2-1.0
apt-get install -y lib32stdc++6
apt-get install -y libc6:i386
apt-get install -y libstdc++6:i386
apt-get install -y zlib1g:i386
apt-get remove ruby
apt-get remove nodejs
apt-get remove ^node-*
apt-get remove nodejs-*
apt-get install ruby2.3 ruby2.3-dev
apt-get autoremove
apt-get autoclean
gem update

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

curl https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | sh
mkdir /home/vagrant/npm-global
npm config set prefix /home/vagrant/npm-global --global

wget http://dl.google.com/android/android-sdk_r24.2-linux.tgz
tar -xvf android-sdk_r24.2-linux.tgz
sudo chown -R vagrant android-sdk-linux/

expect -c '
set timeout -1   ;
spawn /home/vagrant/android-sdk-linux/tools/android update sdk -u --all --filter platform-tool,android-26,build-tools-26
expect {
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'



echo "ANDROID_HOME=~/android-sdk-linux" >> /home/vagrant/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64/" >> /home/vagrant/.profile
echo "PATH=${PATH}:$HOME/android-sdk-linux/platform-tools/:$HOME/android-sdk-linux/tools:$HOME/android-sdk-linux/build-tools/23.0.1/:/home/vagrant/npm-global/bin" >> /home/vagrant/.profile


source /home/vagrant/.profile

npm install npm@latest -g
npm install -g uuid
npm install -g node-gyp
npm install -g node-sass
npm install -g cordova
npm install -g ionic
chown -R vagrant /home/vagrant/npm-global
chmod -R 777 /home/vagrant/npm-global