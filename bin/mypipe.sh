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

# Download and build mypipe
if [ -d "$MYPIPE_DL_DIR" ]; then
  rm -rf $MYPIPE_DL_DIR
fi
mkdir $MYPIPE_DL_DIR
cd $MYPIPE_DL_DIR && git clone git@github.com:mardambey/mypipe.git
cd $MYPIPE_DL_DIR/mypipe && bash ./sbt package

# Copy into the inst_dir
if [ -d "$MYPIPE_INST_DIR" ]; then
  rm -rf $MYPIPE_INST_DIR
fi
cp -Rp $MYPIPE_DL_DIR/mypipe/* $MYPIPE_INST_DIR/