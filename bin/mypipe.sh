#!/bin/bash
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

MYPIPE_DL_DIR=/tmp/mypipe
MYPIPE_INST_DIR=/usr/lib/mypipe

MYSQL_DATA_DIR=/var/lib/mysql-mypipe
MYSQL_CONF_DIR=../conf
MYSQL_CONF_FILE=../conf/mypipe-my.cnf
MYSQL_FINAL_CONF_FILE=/etc/mypipe-my.cnf

MYSQL_DATA_DIR=/var/lib/mysql-mypipe
MYSQL_LOG_DIR=/var/log/mysql-mypipe/
MYSQL_RUN_DIR=/var/run/mysql-mypipe/

# Download and build mypipe
echo -e "\n###  Downloading and Building mypipe"
if [ -d "$MYPIPE_DL_DIR" ]; then
  rm -rf $MYPIPE_DL_DIR
fi
mkdir $MYPIPE_DL_DIR
cd $MYPIPE_DL_DIR && git clone git@github.com:mardambey/mypipe.git
cd $MYPIPE_DL_DIR/mypipe && bash ./sbt package

# Copy into the inst_dir
echo -e "\n###  Installing mypipe to $MYPIPE_INST_DIR"
if [ -d "$MYPIPE_INST_DIR" ]; then
  rm -rf $MYPIPE_INST_DIR
fi
mkdir $MYPIPE_INST_DIR && cp -Rp $MYPIPE_DL_DIR/mypipe/* $MYPIPE_INST_DIR/

# Setup a seperate mysql instance for use with mypipe
echo -e "\n###  Configuring a new MySQL instance"
cp $MYSQL_CONF_FILE $MYSQL_FINAL_CONF_FILE
mkdir -p $MYSQL_DATA_DIR && chown mysql:mysql $MYSQL_DATA_DIR
mkdir -p $MYSQL_LOG_DIR && chown mysql:mysql $MYSQL_LOG_DIR
mkdir -p $MYSQL_RUN_DIR && chown mysql:mysql $MYSQL_RUN_DIR
mysql_install_db --user=mysql --datadir $MYSQL_DATA_DIR
mysqld_safe --defaults-file=$MYSQL_FINAL_CONF_FILE
