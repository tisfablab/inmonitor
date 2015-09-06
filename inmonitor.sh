#!/bin/sh
# /etc/init.d/inmonitor

### BEGIN INIT INFO
# Provides:          in-monitor
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts up the inmonitor scripts.
# Description:       This service is used to gather data from different sources and send them to the cloud server/database. Furthermore, it adds an URL link to the local IP.
### END INIT INFO

MYPATH="/home/pi/inmonitor/python"
SCRIPT="inmonitor.py"

case "$1" in 
    start)
	echo "Starting inmonitor"
	$MYPATH/$SCRIPT >/dev/null 2>&1 &
        ;;
    test)
        echo "(Re)Starting inmonitor in verbose mode"
	killall $SCRIPT >/dev/null 2>&1
        $MYPATH/$SCRIPT
        ;;
    stop)
        echo "Stopping inmonitor"
        killall $SCRIPT >/dev/null 2>&1
        ;;
    *)
        echo "Usage: service inmonitor start|stop|test"
        exit 1
        ;;
esac

exit 0

