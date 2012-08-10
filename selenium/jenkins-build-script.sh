#!/bin/bash

# Jenkins should run this script to get browserid code and test it.

# this is the build step in jenkins--we should put this in a bash file:
rm -f dev
rm -rf mozilla-browserid-*
# TODO make this a ENV VAR
wget http://github.com/mozilla/browserid/tarball/dev
tar xzvf dev
cd mozilla-browserid-*
cd automation-tests
virtualenv bid_selenium
. bid_selenium/bin/activate
pip install -Ur requirements.txt
python -m py.test --destructive --baseurl=http://localhost:8765 \
    --driver=firefox -q 123done

