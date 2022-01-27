#!/bin/bash
export PATH=$PATH:/usr/local/bin
which pip >/dev/null
if [ $? -ne 0 ];
then
  echo 'PIP NOT PRESENT'
  if [ -n "$(which yum)" ];
  then
    yum install -y python-pip
  else
    apt-get -y update && apt-get -y install python-pip
  fi
else
  echo 'PIP ALREADY PRESENT'
fi
