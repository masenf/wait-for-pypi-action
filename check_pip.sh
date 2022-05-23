#!/bin/bash

PACKAGE_NAME=$1
PACKAGE_VERSION=$2
TIMEOUT=${3-30}
DELAY_BETWEEN_REQUESTS=${4-1}

function check_pip() {
  pip install --no-cache-dir --no-deps $PACKAGE_NAME==$PACKAGE_VERSION &> /dev/null;
  if [ $? -ne 0 ]; then
    echo "Could not find version $PACKAGE_VERSION, trying again in $DELAY_BETWEEN_REQUESTS seconds."
    sleep $DELAY_BETWEEN_REQUESTS;
    check_pip;
  else
    pip uninstall $PACKAGE_NAME==$PACKAGE_VERSION -y > /dev/null
    echo "$PACKAGE_NAME==$PACKAGE_VERSION is available!"
  fi
}
check_pip