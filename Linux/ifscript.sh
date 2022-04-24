#!/bin/bash

#creating variable to hold script directory

outdir=$HOME/Desktop/research/sys_info.txt

if [ -d ~/Desktop/research ]
then
  echo "Directory already exists, continue working"
else
  mkdir ~/Desktop/research && echo Research directory has been created.
fi

if [ -f ~/Desktop/research/sys_info.txt ]
then 
  rm $outdir && echo "sys_info.txt has been removed."
else
  echo "File does not exist, sorry."
fi


#check UID - please use $UID

if [ $UID = 0 ]
then
  echo "Command was run as root, lock down the system!"
  sleep 1
  echo 3
  sleep 1
  echo 2
  sleep 1
  echo 1
  sleep 1
  echo "Self-destruct sequence initiated."
else
  echo "Command was not run as root, you haven't been hacked."
fi

echo "System Information" >> $outdir
