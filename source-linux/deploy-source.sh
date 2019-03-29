#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

DIST_DIR_NAME=pcapplusplus-$(cat ../PcapPlusPlus-Deploy/misc/latest_release.version)-source-linux

sudo mkdir -p $DIST_DIR_NAME/PcapPlusPlus

sudo rsync -av --exclude='.git' --exclude="$DIST_DIR_NAME" . $DIST_DIR_NAME/PcapPlusPlus
sudo cp ../PcapPlusPlus-Deploy/source-linux/install* $DIST_DIR_NAME/
sudo cp ../PcapPlusPlus-Deploy/source-linux/uninstall* $DIST_DIR_NAME/

sudo cp ../PcapPlusPlus-Deploy/READMEs/README.release.header $DIST_DIR_NAME/README.release
sudo tee -a $DIST_DIR_NAME/README.release < ../PcapPlusPlus-Deploy/READMEs/README.release.source
sudo tee -a $DIST_DIR_NAME/README.release < ../PcapPlusPlus-Deploy/READMEs/release_notes.txt 

sudo mkdir $DIST_DIR_NAME/example-app
sudo cp Examples/Tutorials/Tutorial-HelloWorld/main.cpp $DIST_DIR_NAME/example-app
sudo cp Examples/Tutorials/Tutorial-HelloWorld/1_packet.pcap $DIST_DIR_NAME/example-app
sudo cp ../PcapPlusPlus-Deploy/linux-mac/Makefile.non_windows $DIST_DIR_NAME/example-app/Makefile

sudo tar -zcvf $DIST_DIR_NAME.tar.gz $DIST_DIR_NAME/

# upload to upfile.sh
rtn=$(curl --upload-file ./$DIST_DIR_NAME.tar.gz https://upfile.sh/$DIST_DIR_NAME.tar.gz)
echo $rtn

# upload to 0x0.st
echo Uploading $DIST_DIR_NAME.tar.gz ...
rtn=$(curl -F "file=@./$DIST_DIR_NAME.tar.gz" https://0x0.st)
echo $rtn