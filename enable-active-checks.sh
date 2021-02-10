#!/bin/sh
# This script enables Zabbix active checks 
sudo cp /usr/local/etc/zabbix52/zabbix_server.conf /usr/local/etc/zabbix52/zabbix_server.conf.bkp 
sudo sed -i '' 's/ListenIP=127.0.0.1/ListenIP=0.0.0.0/g' /usr/local/etc/zabbix52/zabbix_server.conf
sudo service zabbix_server restart
exit 0