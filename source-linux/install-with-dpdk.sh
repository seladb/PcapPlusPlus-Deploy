#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

# set Script Name variable
SCRIPT=`basename ${BASH_SOURCE[0]}`

NUMARGS=$#
if [ $NUMARGS -eq 0 ]; then echo -e "Please specify DPDK home directory. Usage: $SCRIPT <DPDK_HOME>" && exit 1; fi

DPDK_HOME="$1"

if [ ! -d $DPDK_HOME ]; then echo -e "Directory $DPDK_HOME doesn't exist" && exit 1; fi

cd PcapPlusPlus
./configure-linux.sh --dpdk --dpdk-home $DPDK_HOME
make
sudo make install
