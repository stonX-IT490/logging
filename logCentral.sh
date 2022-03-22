#!/bin/bash

# variables
logDir='/var/log/'$1
logName=$1

touch /var/logCentral/${logName}
touch /var/log/${logName}

# debugging
# echo ${logName}

# check for modifications to logName
while true; do
    inotifywait -e modify ${logDir} &> /dev/null
    php sendLog.php ${logName}
done
