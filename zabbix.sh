#!/bin/sh
sudo pkg install -y zabbix52-agent zabbix52-frontend zabbix52-server mod_php74-7.4.14 apache24-2.4.46 \
mysql57-server
fetch -q --no-verify-peer https://raw.githubusercontent.com/Adiel-Ribeiro/Zabbix/master/httpd.conf
fetch -q --no-verify-peer https://raw.githubusercontent.com/Adiel-Ribeiro/Zabbix/master/my.cnf
fetch -q --no-verify-peer https://raw.githubusercontent.com/Adiel-Ribeiro/Zabbix/master/zabbix_agentd.conf
fetch -q --no-verify-peer https://raw.githubusercontent.com/Adiel-Ribeiro/Zabbix/master/zabbix_server.conf
sudo mv httpd.conf /usr/local/etc/apache24/ 
sudo chown root /usr/local/etc/apache24/httpd.conf
sudo chmod 400 /usr/local/etc/apache24/httpd.conf 
sudo mv my.cnf /usr/local/etc/mysql/
sudo chown mysql /usr/local/etc/mysql/my.cnf 
sudo chmod 400 /usr/local/etc/mysql/my.cnf 
sudo mv zabbix_agentd.conf /usr/local/etc/zabbix52/ 
sudo chown root /usr/local/etc/zabbix52/zabbix_agentd.conf
sudo chmod 400 /usr/local/etc/zabbix52/zabbix_agentd.conf 
sudo mv zabbix_server.conf /usr/local/etc/zabbix52/
sudo chown root /usr/local/etc/zabbix52/zabbix_server.conf
sudo chmod 400 /usr/local/etc/zabbix52/zabbix_server.conf
sudo sh -c "echo zabbix_agentd_enable="YES" >> /etc/rc.conf" 
sudo sh -c "echo zabbix_server_enable="YES" >> /etc/rc.conf" 
sudo sh -c "echo mysql_enable="YES" >> /etc/rc.conf" 
sudo sh -c "echo apache24_enable="YES" >> /etc/rc.conf" 
sudo sh -c "echo apache24_http_accept_enable="YES" >> /etc/rc.conf" 
sudo mkdir /var/log/apache
sudo chown www /var/log/apache
sudo chmod 700 /var/log/apache
fetch -q --no-verify-peer https://raw.githubusercontent.com/Adiel-Ribeiro/Zabbix/master/zabbix.conf.php
sudo mv zabbix.conf.php /usr/local/www/zabbix52/conf/
sudo chown www /usr/local/www/zabbix52/conf/zabbix.conf.php 
sudo chmod 400 /usr/local/www/zabbix52/conf/zabbix.conf.php
sudo sh -c "echo post_max_size=16M >> /usr/local/etc/php.ini"
sudo sh -c "echo max_execution_time=300 >> /usr/local/etc/php.ini"
sudo chown root /usr/local/etc/php.ini
sudo chmod 400 /usr/local/etc/php.ini
sudo chmod 400 /usr/local/www/zabbix52/index.php
sudo chown www /usr/local/www/zabbix52/index.php
sudo chflags schg /usr/local/www/zabbix52/index.php
sudo service apache24 restart
sudo mkdir /usr/local/etc/zabbix52/ssh/
sudo chown ec2-user:zabbix /usr/local/etc/zabbix52/ssh/
sudo chmod 770 /usr/local/etc/zabbix52/ssh/
sudo mkdir /var/run/mysql 
sudo chmod 755 /var/run/mysql
sudo chown mysql /var/run/mysql
sudo service mysql-server restart
fetch -q --no-verify-peer https://raw.githubusercontent.com/Adiel-Ribeiro/Zabbix/master/user-my.cnf
mv user-my.cnf .my.cnf 
chown ec2-user .my.cnf 
chmod 600 .my.cnf
sudo mv /root/.mysql_secret /home/ec2-user
sudo chown ec2-user .mysql_secret
echo password=`cat .mysql_secret | awk 'NR==2'` >> .my.cnf
