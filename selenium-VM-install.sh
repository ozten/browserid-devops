#!/bin/bash

################### do ALL THE THINGS as sudoer

echo "*** Unfucking networking ***" > 2
# TODO make this not necessary by fixing the base image
rm -f install.log
touch install.log
sudo rm -rf /etc/udev/rules.d/70-persistent-net.rules > install.log
echo "*** donezo ***" > 2

echo "*** Provisioning Jenkins ***" > 2
# here are instructions: https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key >> install.log | sudo apt-key add - >> install.log
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -q -y jenkins
echo "*** donezo ***" > 2

# jenkins should now be running on localhost:8080 inside that VM.

echo "*** Installing node and npm via apt ***" > 2
sudo apt-get install -q -y python-software-properties
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -q -y nodejs npm
echo "*** donezo ***" > 2

# before running tests, we need to get an RP (for now, 123done) up and running
# locally.
#
# this probably could happen just once per VM, but it might get out of date
# for long-running instances. for now, we'll just do this once per VM.
#
# following the mozilla/123done README:
# TODO where should I put this in the VM? looks like it'll run from root's
# home directory as is...
echo "*** Fetching and installing 123done ***" > 2
rm -rf local-RP
rm -rf mozilla-123done-*
wget github.com/mozilla/123done/tarball/local-RP # TODO just until the local RP patch lands in master
tar xzvf local-RP
cd mozilla-123done-*
npm install
export PERSONA_URL="http://192.168.33.11:10002"
export PORT="8765" # 8080 is the default and conflicts with Jenkins
echo "*** donezo ***" > 2

echo "*** Starting 123done and logging to 123done.log ***" > 2
npm start 1>123done.log 2>&1 &
echo "*** donezo ***" > 2

