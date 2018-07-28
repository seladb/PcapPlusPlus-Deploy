#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

cd PcapPlusPlus
sudo make uninstall
make clean
