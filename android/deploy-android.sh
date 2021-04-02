#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

DIST_DIR_NAME=pcapplusplus-$(cat misc/latest_release.version)-android

# download artifact and unzip it
wget https://api.cirrus-ci.com/v1/artifact/build/$CIRRUS_BUILD_ID/temp_package.zip
apt-get install unzip
unzip -o temp_package.zip

# change artifact folder name
mv package $DIST_DIR_NAME

# copy header files
cp -r PcapPlusPlus/Dist/header $DIST_DIR_NAME/include/

# create README.release
cp READMEs/README.release.header $DIST_DIR_NAME/README.release
tee -a $DIST_DIR_NAME/README.release < READMEs/README.release.android
tee -a $DIST_DIR_NAME/README.release < READMEs/release_notes.txt

# package everything
mkdir final_package
tar -zcvf $DIST_DIR_NAME.tar.gz $DIST_DIR_NAME/
mv $DIST_DIR_NAME.tar.gz final_package/
