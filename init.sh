HOSTNAME=hostname
sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get -y install libdb++-dev build-essential libtool autotools-dev autoconf libssl-dev libboost-all-dev python-software-properties curl vim git debconf-utils

echo '#### Installing Bitcoin client ####'
sudo useradd -d /home/bitcoind -m bitcoind -s /bin/bash
sudo add-apt-repository -y ppa:bitcoin/bitcoin && sudo apt-get -y update
sudo apt-get -y install bitcoind
mkdir /home/bitcoind/.bitcoin/
touch /home/bitcoind/.bitcoin/bitcoin.conf
echo "rpcuser=bitcoinrpc
rpcpassword=`openssl rand -hex 16`
server=1" > /home/bitcoind/.bitcoin/bitcoin.conf
chown -R bitcoind.bitcoind /home/bitcoind/.bitcoin
su bitcoind -c "/usr/bin/bitcoind -daemon"
sed -i -e '$i \su bitcoind -c "/usr/bin/bitcoind -daemon" &\n' /etc/rc.local
echo '#### Finished installing Bitcoin client ####'

echo '#### Installing AuroraCoin client ####'
sudo useradd -d /home/auroracoind -m auroracoind -s /bin/bash
git clone https://github.com/baldurodinsson/auroracoin-project.git
cd auroracoin-project/src
make -f makefile.unix USE_UPNP= AuroraCoind
mv AuroraCoind /usr/bin/auroracoind
mkdir /home/auroracoind/.AuroraCoin/
touch /home/auroracoind/.AuroraCoin/AuroraCoin.conf
echo "rpcuser=auroracoinrpc
rpcpassword=`openssl rand -hex 16`
server=1" > /home/auroracoind/.AuroraCoin/AuroraCoin.conf
chown -R auroracoind.auroracoind /home/auroracoind/.AuroraCoin
su auroracoind -c /usr/bin/auroracoind -daemon
sed -i -e '$i \su auroracoind -c "/usr/bin/auroracoind -daemon" &\n' /etc/rc.local
echo '#### Finished installing AuroraCoin client ####'


sudo apt-get -y install php5 php5-common php5-dev php5-mcrypt php5-gmp php5-mysql php5-cli php5-curl
MYSQLPASS=''
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password password ''"
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password_again password ''"
sudo apt-get -y install mysql-server-5.5 apache2

a2enmod rewrite
sudo php5enmod mcrypt
sudo php5enmod bcmath

debconf-set-selections <<< "postfix postfix/mailname string $HOSTNAME"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
apt-get install -y postfix

service apache2 restart
service mysql restart
service postfix restart

echo "#### Downloading Q2A ####"
mkdir /var/www/html
cd /var/www/html
git clone https://github.com/q2a/question2answer.git .
echo "#### Downloading Coin Bounty plugin ####"
cd qa-plugin
git clone https://github.com/Stirling/Coin-Bounty.git coin-bounty
cd /var/www/html
cp qa-config-example.php qa-config.php

Q2ADBPASS=`openssl rand -hex 5`
mysql -u root -p$MYSQLPASS -e 'CREATE DATABASE q2a'
mysql -u root -p$MYSQLPASS -e "CREATE USER 'q2a'@'localhost' IDENTIFIED BY '$Q2ADBPASS';"
mysql -u root -p$MYSQLPASS -e "GRANT ALL PRIVILEGES ON q2a.* TO 'q2a'@'localhost';"
mysql -u root -p$MYSQLPASS -e "FLUSH PRIVILEGES;"

sed -i "s/your-mysql-username/q2a/" qa-config.php
sed -i "s/your-mysql-password/$Q2ADBPASS/" qa-config.php
sed -i "s/your-mysql-db-name/q2a/" qa-config.php

apt-get -y autoremove

#crontab -l | { cat; echo "* * * * * /usr/bin/curl http://127.0.0.1/cron-update-deposit > /dev/null 2>&1"; } | crontab -