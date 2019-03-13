#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then XCODE_VER=$($(xcode-select -print-path)/usr/bin/xcodebuild -version | head -n1 | awk '{print $2}') ; fi
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then OS_VER=mac-os-$(sw_vers -productVersion)-xcode-$XCODE_VER; fi

DIST_DIR_NAME=pcapplusplus-$(cat ../PcapPlusPlus-Deploy/misc/latest_release.version)-$OS_VER-gcc-$(cat gcc.version)

# change Dist folder name
mv Dist $DIST_DIR_NAME

# create README.release
sudo cp ../PcapPlusPlus-Deploy/READMEs/README.release.header $DIST_DIR_NAME/README.release
sudo tee -a $DIST_DIR_NAME/README.release < ../PcapPlusPlus-Deploy/READMEs/README.release.linux_mac
sudo tee -a $DIST_DIR_NAME/README.release < ../PcapPlusPlus-Deploy/READMEs/release_notes.txt

# copy and modify example app
sudo mkdir $DIST_DIR_NAME/example-app
sudo cp Examples/Tutorials/Tutorial-HelloWorld/main.cpp $DIST_DIR_NAME/example-app
sudo cp Examples/Tutorials/Tutorial-HelloWorld/1_packet.pcap $DIST_DIR_NAME/example-app
sudo cp ../PcapPlusPlus-Deploy/linux-mac/Makefile.non_windows $DIST_DIR_NAME/example-app/Makefile

# modify PcapPlusPlus.mk
sudo sed -i.bak "s|PCAPPLUSPLUS_HOME :=.*|PCAPPLUSPLUS_HOME := /PcapPlusPlus/Home/Dir|g" $DIST_DIR_NAME/mk/PcapPlusPlus.mk && sudo rm $DIST_DIR_NAME/mk/PcapPlusPlus.mk.bak
sudo sed -i.bak "s|Dist/||g" $DIST_DIR_NAME/mk/PcapPlusPlus.mk && sudo rm $DIST_DIR_NAME/mk/PcapPlusPlus.mk.bak
sudo sed -i.bak "s|Dist||g" $DIST_DIR_NAME/mk/PcapPlusPlus.mk && sudo rm $DIST_DIR_NAME/mk/PcapPlusPlus.mk.bak

# copy and modify installation scripts
sudo cp mk/install.sh $DIST_DIR_NAME/
sudo cp mk/uninstall.sh $DIST_DIR_NAME/
printf "\necho Installation complete! " | sudo tee -a $DIST_DIR_NAME/install.sh
printf "\necho Uninstallation complete! " | sudo tee -a $DIST_DIR_NAME/uninstall.sh

# package everything
sudo tar -zcvf $DIST_DIR_NAME.tar.gz $DIST_DIR_NAME/

# upload to upfile.sh
curl --upload-file ./$DIST_DIR_NAME.tar.gz https://upfile.sh/$DIST_DIR_NAME.tar.gz -o upfile.out
cat upfile.out
