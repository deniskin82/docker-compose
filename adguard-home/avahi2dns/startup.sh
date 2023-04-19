#!/usr/bin/env sh
IP=`ip a s eth0 | grep -E -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d' ' -f2`
#dbus-daemon --system --nofork
/usr/bin/avahi2dns --addr ${IP} --port 5454 -v
