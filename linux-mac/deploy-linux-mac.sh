#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then OS_VER=$DOCKER_IMAGE; fi
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then XCODE_VER=$($(xcode-select -print-path)/usr/bin/xcodebuild -version | head -n1 | awk '{print $2}') ; fi
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then OS_VER=mac-os-$(sw_vers -productVersion)-xcode-$XCODE_VER; fi

DIST_DIR_NAME=pcapplusplus-$(cat Deploy/latest_release.version)-$OS_VER

mv Dist $DIST_DIR_NAME

NEW_FIRST_LINE="PCAPPLUSPLUS_HOME := /your/PcapPlusPlus/folder"
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then SED_PARAMS="''"; fi

sed -i $SED_PARAMS "1s|.*|$NEW_FIRST_LINE|" $DIST_DIR_NAME/mk/PcapPlusPlus.mk

sed -i $SED_PARAMS "s|"$(PCAPPLUSPLUS_HOME)/Dist"|"$(PCAPPLUSPLUS_HOME)"|" $DIST_DIR_NAME/mk/PcapPlusPlus.mk

cp ../PcapPlusPlus-Deploy/READMEs/README.release.linux_mac $DIST_DIR_NAME/README.release

mkdir $DIST_DIR_NAME/example-app
cp Examples/Tutorials/Tutorial-HelloWorld/main.cpp $DIST_DIR_NAME/example-app
cp Examples/Tutorials/Tutorial-HelloWorld/1_packet.pcap $DIST_DIR_NAME/example-app
cp ../PcapPlusPlus-Deploy/misc/Makefile $DIST_DIR_NAME/example-app

tar -zcvf $DIST_DIR_NAME.tar.gz $DIST_DIR_NAME/
curl --upload-file ./$DIST_DIR_NAME.tar.gz https://transfer.sh/$DIST_DIR_NAME.tar.gz
