#!/bin/bash

# Create the mypipe database
echo -e "\n###  Creating the mypipe database"
mysql --host "127.0.0.1" -P $MYSQL_PORT -u $MYSQL_USER -p$MYSQL_PASS -Be "CREATE DATABASE mypipe;"