#!/bin/bash

if [ -n "$1" ]; then
  MYSQL_PORT=$1
else
  MYSQL_PORT=44001
fi
MYSQL_USER=root
MYSQL_PASS=horton

# Create the mypipe database
echo -e "\n###  Creating the mypipe database"
mysql --host "127.0.0.1" -P $MYSQL_PORT -u $MYSQL_USER -p$MYSQL_PASS -Be "CREATE DATABASE mypipe;"