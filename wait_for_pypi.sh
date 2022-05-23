#!/bin/bash
set -eux

PACKAGE_NAME=$1
PACKAGE_VERSION=$2
TIMEOUT=${3-30}
DELAY_BETWEEN_REQUESTS=${4-1}

DELAY_BETWEEN_REQUESTS=$DELAY_BETWEEN_REQUESTS \
  PACKAGE_NAME=$PACKAGE_NAME \
  PACKAGE_VERSION=$PACKAGE_VERSION \
  FOUND=0 \
  timeout \
  --foreground -s TERM $TIMEOUT bash -c \
    'while pip download $PACKAGE_NAME==$PACKAGE_VERSION --no-deps --no-cache-dir -d /tmp/databutton; [ $? -ne 0 ]; do
        sleep $DELAY_BETWEEN_REQUESTS;
    done;
    rm -rf /tmp/databutton
    echo "success with package: $PACKAGE_NAME@$PACKAGE_VERSION"'
