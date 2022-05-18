#!/bin/bash
set -eux

PACKAGE_NAME=$1
PACKAGE_VERSION=$2
TIMEOUT=${3-30}
DELAY_BETWEEN_REQUESTS=${4-1}

declare URL=https://pypi.org/simple/$PACKAGE_NAME/

DELAY_BETWEEN_REQUESTS=$DELAY_BETWEEN_REQUESTS \
  PACKAGE_NAME=$PACKAGE_NAME \
  PACKAGE_VERSION=$PACKAGE_VERSION \
  URL=$URL \
  FOUND=0 \
  timeout \
  --foreground -s TERM $TIMEOUT bash -c \
    'while [[ $FOUND -eq 0 ]]; do
        FOUND=$(curl -s -L ${URL} | grep "$PACKAGE_VERSION" | wc -l)
        echo "found: $FOUND"
        sleep $DELAY_BETWEEN_REQUESTS;
    done;
    echo "success with package: $PACKAGE_NAME@$PACKAGE_VERSION"'
