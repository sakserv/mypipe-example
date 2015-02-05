#!/bin/bash

SCRIPT_NAME=`basename $0`
SCRIPT_PATH=$(cd `dirname $0` && pwd)

if [ -n "$1" ]; then
  MYSQL_PORT=$1
else
  MYSQL_PORT=44001
fi

MYSQL_URL="http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.23-linux-glibc2.5-x86_64.tar.gz"
MYSQL_SANDBOX_URL="https://launchpad.net/mysql-sandbox/mysql-sandbox-3/mysql-sandbox-3/+download/MySQL-Sandbox-3.0.47.tar.gz"
BUILD_DIR=/tmp/mysql_sandbox
MYSQL_USER=root
MYSQL_PASS=horton

# Grab mysql and mysql-sandbox
echo -e "\n###  Downloading mysql and mysql-sandbox"
if [ -d "$BUILD_DIR" ]; then
  rm -rf $BUILD_DIR
fi
mkdir -p $BUILD_DIR
cd $BUILD_DIR && wget $MYSQL_SANDBOX_URL
cd $BUILD_DIR && wget $MYSQL_URL

# Build and install mysql-sandbox
echo -e "\n### Installing mysql-sandbox"
cd $BUILD_DIR && tar -xf MySQL-Sandbox-*
cd $BUILD_DIR/MySQL-Sandbox-* && perl Makefile.PL
cd $BUILD_DIR/MySQL-Sandbox-* && make
cd $BUILD_DIR/MySQL-Sandbox-* && make test
cd $BUILD_DIR/MySQL-Sandbox-* && make install

# Start the sandbox
echo -e "\n### Starting the mysql-sandbox on port $MYSQL_PORT"
export SANDBOX_AS_ROOT=1
make_sandbox $BUILD_DIR/mysql-* -- --no_confirm --db_user=$MYSQL_USER --db_password=$MYSQL_PASS --sandbox_port=$MYSQL_PORT

# Run the ddl script
bash $SCRIPT_PATH/ddl.sh $MYSQL_PORT