#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

DIST_DIR_NAME=pcapplusplus-$(cat misc/latest_release.version)-source-linux

sudo mkdir -p $DIST_DIR_NAME/PcapPlusPlus

sudo rsync -av --exclude='.git' PcapPlusPlus/ $DIST_DIR_NAME/PcapPlusPlus
sudo cp source-linux/install* $DIST_DIR_NAME/
sudo cp source-linux/uninstall* $DIST_DIR_NAME/

sudo cp READMEs/README.release.header $DIST_DIR_NAME/README.release
sudo tee -a $DIST_DIR_NAME/README.release < READMEs/README.release.source
sudo tee -a $DIST_DIR_NAME/README.release < READMEs/release_notes.txt 

sudo mkdir $DIST_DIR_NAME/example-app
sudo cp PcapPlusPlus/Examples/Tutorials/Tutorial-HelloWorld/main.cpp $DIST_DIR_NAME/example-app
sudo cp PcapPlusPlus/Examples/Tutorials/Tutorial-HelloWorld/1_packet.pcap $DIST_DIR_NAME/example-app
sudo cp linux-mac/Makefile.non_windows $DIST_DIR_NAME/example-app/Makefile

# package everything
mkdir package
tar -zcvf ../package/$DIST_DIR_NAME.tar.gz $DIST_DIR_NAME/