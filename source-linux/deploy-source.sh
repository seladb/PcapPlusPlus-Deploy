#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

DIST_DIR_NAME=pcapplusplus-$(cat ../PcapPlusPlus-Deploy/misc/latest_release.version)-source-linux

sudo mkdir -p $DIST_DIR_NAME/PcapPlusPlus

sudo rsync -av --exclude='.git' --exclude="$DIST_DIR_NAME" . $DIST_DIR_NAME/PcapPlusPlus
sudo cp ../PcapPlusPlus-Deploy/source-linux/install* $DIST_DIR_NAME/

sudo cp ../PcapPlusPlus-Deploy/READMEs/README.release.header $DIST_DIR_NAME/README.release
sudo cat ../PcapPlusPlus-Deploy/READMEs/README.release.source >> $DIST_DIR_NAME/README.release
sudo cat ../PcapPlusPlus-Deploy/READMEs/release_notes.txt >> $DIST_DIR_NAME/README.release

sudo mkdir $DIST_DIR_NAME/example-app
sudo cp Examples/Tutorials/Tutorial-HelloWorld/main.cpp $DIST_DIR_NAME/example-app
sudo cp Examples/Tutorials/Tutorial-HelloWorld/1_packet.pcap $DIST_DIR_NAME/example-app
sudo cp ../PcapPlusPlus-Deploy/linux-mac/Makefile.non_windows $DIST_DIR_NAME/example-app/Makefile

sudo tar -zcvf $DIST_DIR_NAME.tar.gz $DIST_DIR_NAME/
curl --upload-file ./$DIST_DIR_NAME.tar.gz https://transfer.sh/$DIST_DIR_NAME.tar.gz
