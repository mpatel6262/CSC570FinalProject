#!/bin/bash

echo "@@@INSIDE SERVER COLLECTL SCRIPT@@@"

sudo collectl -sCD >& ~/collectl/"$1"&

echo "@@@OUTSIDE SERVER COLLECTL SCRIPT@@@"

sleep 1 
#sudo killall collectl
