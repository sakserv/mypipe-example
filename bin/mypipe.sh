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

# Source the config
. /tmp/mypipe-example/conf/env.cfg

# Download and build mypipe
echo -e "\n###  Downloading mypipe"
if [ -d "$MYPIPE_DL_DIR" ]; then
  rm -rf $MYPIPE_DL_DIR
fi
mkdir $MYPIPE_DL_DIR
cd $MYPIPE_DL_DIR && git clone $MYPIPE_GIT_URL

# Copy into the inst_dir
echo -e "\n###  Installing mypipe to $MYPIPE_INST_DIR"
if [ -d "$MYPIPE_INST_DIR" ]; then
  rm -rf $MYPIPE_INST_DIR
fi
mkdir $MYPIPE_INST_DIR && cp -Rp $MYPIPE_DL_DIR/mypipe/* $MYPIPE_INST_DIR/

# Building mypipe
echo -e "\n###  Building mypipe"
cd $MYPIPE_INST_DIR && bash ./sbt package

# Lay down the populated application.conf
echo -e "\n###  Populating and installing application.conf"
sed -e "s|@@DBHOST@@|$MYPIPE_DBHOST|g" \
    -e "s|@@DBPORT@@|$MYPIPE_DBPORT|g" \
    -e "s|@@DBUSER@@|$MYPIPE_DBUSER|g" \
    -e "s|@@DBPASSWORD@@|$MYPIPE_DBPASSWORD|g" \
    -e "s|@@KAFKABROKERLIST@@|$KAFKA_BROKER_LIST|g" $MYPIPE_APP_CONF_SRC >$MYPIPE_APP_CONF_DEST
    
# Create the log dir
if [ ! -d "$MYPIPE_LOG_DIR" ]; then
  echo -e "\n### Creating log dir $MYPIPE_LOG_DIR"
  mkdir -p $MYPIPE_LOG_DIR
fi

# Start mypipe
echo -e "\n###  Starting mypipe"
echo -e "Logging to: $MYPIPE_LOG"
cd $MYPIPE_INST_DIR && bash ./sbt "project runner" "runMain mypipe.runner.PipeRunner" >>$MYPIPE_LOG 2>&1 &