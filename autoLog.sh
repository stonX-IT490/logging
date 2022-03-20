#!/bin/bash

# SEND: watch for modification to logfile then run sendLog()
nohup bash logCentral.sh ufw.log &
nohup bash logCentral.sh messages &
nohup basg logCentral.sh syslog &
nohup bash logCentral.sh nginx/error.log &

# RECEIVE: run php receiveLog for each logfile
nohup php receiveLog.php ufw.log &
nohup php receiveLog.php messages &
nohup php receiveLog.php syslog &
nohup php receiveLog.php nginx/error.log
