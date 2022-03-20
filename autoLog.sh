#!/bin/bash

# SEND: watch for modification to logfile then run sendLog()
./logCentral.sh ufw.log &
./logCentral.sh messages &
./logCentral.sh syslog &
./logCentral.sh nginx/error.log &

# RECEIVE: run php receiveLog for each logfile
php receiveLog.php ufw.log &
php receiveLog.php messages &
php receiveLog.php syslog &
php receiveLog.php nginx/error.log &
