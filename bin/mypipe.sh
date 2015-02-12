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
MYPIPE_APP_CONF_SRC=/tmp/mypipe-example/conf/application.conf
MYPIPE_DBNAME=mypipe
MYPIPE_DBPORT=44001
MYPIPE_DBUSER=root
MYPIPE_DBPASSWORD=horton

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

# Lay down the populated application.conf
echo -e "\n###  Populating and installing application.conf"
sed -i "s|@@DBNAME@@|$MYPIPE_DBNAME|g" $MYPIPE_APP_CONF_SRC
sed -i "s|@@DBPORT@@|$MYPIPE_DBPORT|g" $MYPIPE_APP_CONF_SRC
sed -i "s|@@DBUSER@@|$MYPIPE_DBUSER|g" $MYPIPE_APP_CONF_SRC
sed -i "s|@@DBPASSWORD@@|$MYPIPE_DBPASSWORD|g" $MYPIPE_APP_CONF_SRC
