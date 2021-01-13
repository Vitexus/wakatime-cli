#!/bin/bash

# suppress stderr output
exec 2>/dev/null

LATEST_TAG=$(git describe --tags --abbrev=0 || :)

if [ "$LATEST_TAG" == "" ]; then
	LATEST_TAG="0.0.0"
fi

if [[ ${LATEST_TAG} != *alpha* ]]; then
	CURRENT_MINOR=$(echo $LATEST_TAG | awk -F. '{print $2}')
	NEXT_MINOR=$((${CURRENT_MINOR}+1))
	NEXT_BASE_TAG=$(echo $LATEST_TAG | awk -F. '{print $1".'$NEXT_MINOR'."$3}')
	NEXT_ALPHA_INCREMENT="1"
else
	NEXT_BASE_TAG=$(echo $LATEST_TAG | awk -F- '{print $1}')
	LATEST_ALPHA_TAG_INCREMENT=$(echo $LATEST_TAG | awk -F. '{print $NF}')
	NEXT_ALPHA_INCREMENT=$(($LATEST_ALPHA_TAG_INCREMENT+1))
fi

echo "${NEXT_BASE_TAG}-alpha.${NEXT_ALPHA_INCREMENT}"
