#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

cd PcapPlusPlus
./configure-linux.sh --default
make
sudo make install
