#!/bin/bash
# Builds the container.
# The container can be exported using the export.sh script
CONTAINER=flywheel/siemens2ismrmrd
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker build --tag $CONTAINER $DIR
