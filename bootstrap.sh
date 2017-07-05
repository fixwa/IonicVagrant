#!/usr/bin/env bash
SDKMAN_DIR=/home/vagrant

dpkg --configure -a
dpkg --add-architecture i386
apt-add-repository ppa:brightbox/ruby-ng -y
sudo add-apt-repository ppa:webupd8team/java

apt-get update
apt-get upgrade
apt-get -u dist-upgrade
apt-get -f install
apt-get install -y zip
apt-get install -y yum
apt-get install -y git
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

#apt-get remove java*
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
apt-get install -y oracle-java8-installer
apt-get install -y oracle-java8-set-default

apt-get autoremove
apt-get autoclean
gem update

mkdir /usr/android-sdk-linux
wget http://dl.google.com/android/android-sdk_r24.2-linux.tgz
tar -xvf android-sdk_r24.2-linux.tgz -C /usr/android-sdk-linux --strip-components=1

expect -c '
set timeout -1   ;
spawn /usr/android-sdk-linux/tools/android update sdk --no-ui -u --all --filter build-tools-25.0.1,android-25,extra-android-m2repository
expect {
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'
sudo chown -R vagrant /usr/android-sdk-linux

echo "ANDROID_HOME=/usr/android-sdk-linux" >> /home/vagrant/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /home/vagrant/.profile
echo "PATH=${PATH}:/usr/android-sdk-linux/platform-tools/:/usr/android-sdk-linux/tools:/usr/android-sdk-linux/build-tools/23.0.1/:/usr/npm-global/bin" >> /home/vagrant/.profile
echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/environment
echo "JRE_HOME=/usr/lib/jvm/java-8-oracle/jre" >> /etc/environment

source /home/vagrant/.profile

curl -s "https://get.sdkman.io" | bash
source "${SDKMAN_DIR}/bin/sdkman-init.sh"
sdk install gradle

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install -y nodejs

rm -rf /usr/npm-global
mkdir /usr/npm-global
npm config set prefix /usr/npm-global --global

npm install -g uuid
#npm install -g --unsafe-perm node-gyp
#npm install -g --unsafe-perm node-sass
npm install -g cordova
npm install -g ionic
chown -R nobody:nogroup /usr/npm-global
chmod -R 777 /usr/npm-global
