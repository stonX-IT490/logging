#!/bin/bash

# RECEIVE: run php receiveLog for each logfile
php receiveLog.php ufw.log &> var/log/receiveLog.log &
php receiveLog.php messages &> var/log/receiveLog.log &
php receiveLog.php syslog &> var/log/receiveLog.log &
php receiveLog.php daemon.log &> var/log/receiveLog.log &
php receiveLog.php nginx/error.log &> var/log/receiveLog.log &

# SEND: watch for modification to logfile then run sendLog()
./logCentral.sh ufw.log &> var/log/logCentral.log &
./logCentral.sh messages &> var/log/logCentral.log &
./logCentral.sh daemon.log &> var/log/logCentral.log &
./logCentral.sh nginx/error.log &> var/log/logCentral.log &
./logCentral.sh daemon.log &> var/log/logCentral.log &
