#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

DIST_DIR_NAME=pcapplusplus-$(cat misc/latest_release.version)-source-linux

mkdir -p $DIST_DIR_NAME/PcapPlusPlus

rsync -av --exclude='.git' PcapPlusPlus/ $DIST_DIR_NAME/PcapPlusPlus
cp source-linux/install* $DIST_DIR_NAME/
cp source-linux/uninstall* $DIST_DIR_NAME/

cp READMEs/README.release.header $DIST_DIR_NAME/README.release
tee -a $DIST_DIR_NAME/README.release < READMEs/README.release.source
tee -a $DIST_DIR_NAME/README.release < READMEs/release_notes.txt 

mkdir $DIST_DIR_NAME/example-app
cp PcapPlusPlus/Examples/Tutorials/Tutorial-HelloWorld/main.cpp $DIST_DIR_NAME/example-app
cp PcapPlusPlus/Examples/Tutorials/Tutorial-HelloWorld/1_packet.pcap $DIST_DIR_NAME/example-app
cp linux-mac/Makefile.non_windows $DIST_DIR_NAME/example-app/Makefile

# package everything
mkdir package
tar -zcvf ../package/$DIST_DIR_NAME.tar.gz $DIST_DIR_NAME/