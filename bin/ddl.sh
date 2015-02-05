#!/bin/bash

if [ -n "$1" ]; then
  MYSQL_PORT=$1
else
  MYSQL_PORT=44001
fi
MYSQL_USER=root
MYSQL_PASS=horton
MYSQL_DATABASE=mypipe
MYSQL_TABLE=testing

# Create the mypipe database
echo -e "\n###  Creating the mypipe database"
mysql --host "127.0.0.1" -P $MYSQL_PORT -u $MYSQL_USER -p$MYSQL_PASS -Be "CREATE DATABASE $MYSQL_DATABASE;"

mysql --host "127.0.0.1" -P $MYSQL_PORT -u $MYSQL_USER -p$MYSQL_PASS -D $MYSQL_DATABASE -Be "CREATE TABLE $MYSQL_TABLE(
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
firstname VARCHAR(30) NOT NULL, 
lastname VARCHAR(30) NOT NULL, 
score INT(3), 
dt TIMESTAMP);"