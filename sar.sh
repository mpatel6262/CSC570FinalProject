#!/bin/bash

echo "@@@INSIDE SAR SCRIPT@@@"

sudo sar -n DEV 1 | grep eth0 >& ~/collectl/"$1"&

echo "@@@OUTSIDE SAR SCRIPT@@@"
sleep 1 
#sudo killall collectl
