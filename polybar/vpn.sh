#!/bin/sh

if [ -d "/proc/sys/net/ipv4/conf/tun0" ]; then
  echo "Connected"
else
  echo "Disconnected"
fi
