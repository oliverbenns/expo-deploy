# !/bin/bash

# Deploy script for Expo
# Usage: Create app.json files in config folder with environment
# as file name. E.g. ./config/production.json || ./config/staging.json.
# Run this script with `./deploy [task] [environment]`.
# Author: @oliverbenns

TASK=$1 # "build" or "publish"
ENVIRONMENT=$2 # "production", "staging" etc.

BASE_DIR="$(dirname "$0")"
CONFIG_FILE="${BASE_DIR}/config/${ENVIRONMENT}.json"
BASE_FILE="${BASE_DIR}/app.json"

if [ ! -f "$CONFIG_FILE" ]
then
  echo "Config does not exist for environment \"${ENVIRONMENT}\"."
  exit 1
fi

if [ "$TASK" == "publish" ] && [ "$ENVIRONMENT" == "production" ]
then
  while true; do
      read -p "Warning: You are about to publish to production. Are you sure you wish to proceed?" yn
      case $yn in
          [Yy]* ) break;;
          [Nn]* ) exit;;
          * ) echo "Answer yes or no.";;
      esac
  done
fi

if [ "$TASK" == "build" ]
then
  cp "$CONFIG_FILE" "$BASE_FILE"
  echo "Building iOS"
  exp build:ios
  echo "Building Android"
  exp build:android
  rm "$BASE_FILE"
elif [ "$TASK" == "publish" ]
then
  cp "$CONFIG_FILE" "$BASE_FILE"
  echo "Publishing to Expo"
  exp publish
  rm "$BASE_FILE"
else
  echo "Task \"${TASK}\" is not valid. Must either be \"build\" or \"publish\"."
  exit 1
fi
