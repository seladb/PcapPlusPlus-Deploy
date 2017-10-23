#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

# set Script Name variable
SCRIPT=`basename ${BASH_SOURCE[0]}`

NUMARGS=$#
if [ $NUMARGS -eq 0 ]; then echo -e "Please specify PF_RING home directory. Usage: $SCRIPT <PF_RING_HOME>" && exit 1; fi

PFRING_HOME="$1"

if [ ! -d $PFRING_HOME ]; then echo -e "Directory $PFRING_HOME doesn't exist" && exit 1; fi

cd PcapPlusPlus
./configure-linux.sh --pf-ring --pf-ring-home $PFRING_HOME
make
sudo make install
