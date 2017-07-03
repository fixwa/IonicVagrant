#!/usr/bin/env bash

dpkg --configure -a
dpkg --add-architecture i386

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
apt-get autoclean

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

npm install -g npm
gem install sass
sudo npm install --unsafe-perm -g node-gyp
sudo npm install --unsafe-perm -g node-sass

wget http://dl.google.com/android/android-sdk_r24.2-linux.tgz
tar -xvf android-sdk_r24.2-linux.tgz
sudo chown -R vagrant android-sdk-linux/

expect -c '
set timeout -1   ;
spawn /home/vagrant/android-sdk-linux/tools/android update sdk -u --all
expect {
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'

echo "ANDROID_HOME=~/android-sdk-linux" >> /home/vagrant/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64/" >> /home/vagrant/.zshrc
echo "PATH=${PATH}:$HOME/android-sdk-linux/platform-tools/:$HOME/android-sdk-linux/tools:$HOME/android-sdk-linux/build-tools/23.0.1/" >> /home/vagrant/.zshrc

source /home/vagrant/.zshrc

npm install -g cordova
npm install -g ionic
