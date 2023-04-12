#!/usr/bin/env bash

# TODO: Define env variables
DISK="/dev/vda"
USER_NAME="luka"

ROOT_PASSWORD=""
USER_PASSWORD=""

# system information
PROCESSOR_TYPE="Intel"
if [ "$(lscpu | grep 'AMD')" ];
then
    PROCESSOR_TYPE="AMD"
fi
