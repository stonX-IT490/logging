#!/bin/bash

# variables
logDir='/var/log/'$1
logName=$1

touch /var/log/logCentral/${logName}

# debugging
echo ${logName}

# check for modifications to logName
while true; do
    sudo inotifywait -e modify ${logDir}
    sudo php sendLog.php ${logName}
done