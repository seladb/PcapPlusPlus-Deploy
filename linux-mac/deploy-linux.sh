#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

g++ -dumpversion > gcc.version
DIST_DIR_NAME=pcapplusplus-$(cat misc/latest_release.version)-$OS_VER-gcc-$(cat gcc.version)

# change Dist folder name
mv PcapPlusPlus/Dist PcapPlusPlus/$DIST_DIR_NAME

# create README.release
cp READMEs/README.release.header PcapPlusPlus/$DIST_DIR_NAME/README.release
tee -a PcapPlusPlus/$DIST_DIR_NAME/README.release < READMEs/README.release.linux_mac
tee -a PcapPlusPlus/$DIST_DIR_NAME/README.release < READMEs/release_notes.txt

# copy and modify example app
mkdir PcapPlusPlus/$DIST_DIR_NAME/example-app
cp PcapPlusPlus/Examples/Tutorials/Tutorial-HelloWorld/main.cpp PcapPlusPlus/$DIST_DIR_NAME/example-app
cp PcapPlusPlus/Examples/Tutorials/Tutorial-HelloWorld/1_packet.pcap PcapPlusPlus/$DIST_DIR_NAME/example-app
cp linux-mac/Makefile.non_windows PcapPlusPlus/$DIST_DIR_NAME/example-app/Makefile

# modify PcapPlusPlus.mk
sed -i.bak "s|PCAPPLUSPLUS_HOME :=.*|PCAPPLUSPLUS_HOME := /PcapPlusPlus/Home/Dir|g" PcapPlusPlus/$DIST_DIR_NAME/mk/PcapPlusPlus.mk && rm PcapPlusPlus/$DIST_DIR_NAME/mk/PcapPlusPlus.mk.bak
sed -i.bak "s|Dist/||g" PcapPlusPlus/$DIST_DIR_NAME/mk/PcapPlusPlus.mk && rm PcapPlusPlus/$DIST_DIR_NAME/mk/PcapPlusPlus.mk.bak
sed -i.bak "s|Dist||g" PcapPlusPlus/$DIST_DIR_NAME/mk/PcapPlusPlus.mk && rm PcapPlusPlus/$DIST_DIR_NAME/mk/PcapPlusPlus.mk.bak

# copy and modify installation scripts
cp PcapPlusPlus/mk/install.sh PcapPlusPlus/$DIST_DIR_NAME/
cp PcapPlusPlus/mk/uninstall.sh PcapPlusPlus/$DIST_DIR_NAME/
printf "\necho Installation complete! " | tee -a PcapPlusPlus/$DIST_DIR_NAME/install.sh
printf "\necho Uninstallation complete! " | tee -a PcapPlusPlus/$DIST_DIR_NAME/uninstall.sh

# package everything
mkdir package
tar -zcvf package/$DIST_DIR_NAME.tar.gz PcapPlusPlus/$DIST_DIR_NAME/
