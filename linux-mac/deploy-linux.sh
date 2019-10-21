#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

DIST_DIR_NAME=pcapplusplus-$(cat misc/latest_release.version)-$OS_VER-gcc-$(cat gcc.version)

# change Dist folder name
mv PcapPlusPlus/Dist PcapPlusPlus/$DIST_DIR_NAME

# create README.release
sudo cp READMEs/README.release.header PcapPlusPlus/$DIST_DIR_NAME/README.release
sudo tee -a PcapPlusPlus/$DIST_DIR_NAME/README.release < READMEs/README.release.linux_mac
sudo tee -a PcapPlusPlus/$DIST_DIR_NAME/README.release < READMEs/release_notes.txt

# copy and modify example app
sudo mkdir PcapPlusPlus/$DIST_DIR_NAME/example-app
sudo cp PcapPlusPlus/Examples/Tutorials/Tutorial-HelloWorld/main.cpp PcapPlusPlus/$DIST_DIR_NAME/example-app
sudo cp PcapPlusPlus/Examples/Tutorials/Tutorial-HelloWorld/1_packet.pcap PcapPlusPlus/$DIST_DIR_NAME/example-app
sudo cp linux-mac/Makefile.non_windows PcapPlusPlus/$DIST_DIR_NAME/example-app/Makefile

# modify PcapPlusPlus.mk
sudo sed -i.bak "s|PCAPPLUSPLUS_HOME :=.*|PCAPPLUSPLUS_HOME := /PcapPlusPlus/Home/Dir|g" PcapPlusPlus/$DIST_DIR_NAME/mk/PcapPlusPlus.mk && sudo rm $DIST_DIR_NAME/mk/PcapPlusPlus.mk.bak
sudo sed -i.bak "s|Dist/||g" $DIST_DIR_NAME/mk/PcapPlusPlus.mk && sudo rm PcapPlusPlus/$DIST_DIR_NAME/mk/PcapPlusPlus.mk.bak
sudo sed -i.bak "s|Dist||g" $DIST_DIR_NAME/mk/PcapPlusPlus.mk && sudo rm PcapPlusPlus/$DIST_DIR_NAME/mk/PcapPlusPlus.mk.bak
