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

# Download and build mypipe
if [ -d /tmp/mypipe ]; then
  rm -rf /tmp/mypipe
fi
mkdir /tmp/mypipe
cd /tmp/mypipe
git clone git@github.com:mardambey/mypipe.git
cd mypipe && ./sbt package