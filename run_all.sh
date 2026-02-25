#!/bin/sh

## run_all.sh
#
# Usage:
#
# Set environment variables: SERVER_URL
# Pass all configuration file names to process
#

if [ -z "${SERVER_URL}" ]; then
	echo "ERROR: SERVER_URL is not set. Aborting." >&2
	exit 2
fi
# Variables for Rclone
missing=''
for var in RCLONE_CONFIG_S3_ENDPOINT RCLONE_CONFIG_S3_PROVIDER RCLONE_CONFIG_S3_REGION RCLONE_CONFIG_S3_TYPE RCLONE_CONFIG_S3_ENV_AUTH RCLONE_CONFIG_S3_ACL AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
do
	eval "val=\${$var}"
	[ -n "${val}" ] || missing="${missing}${var} "
done
if [ -n "${missing}" ]; then
	echo "ERROR: Missing Rclone configuration variable: ${missing}. Aborting." >&2
	exit 2
fi

## TODO Check settings required for sync

if [ "$#" -eq 0 ]; then
	echo "ERROR: No configuration provided. Aborting." >&2
	exit 1
fi

for feed in "$@"; do
	path="config/${feed}.json"
	if [ ! -s "${path}" ]; then
		echo "ERROR: Configuration '${feed}' not found. Aborting" >&2
		exit 1
	fi
done

echo "Creating GBFS feeds ..."
for feed in "$@"; do
	echo "Processing '${feed}' ..."
	python -m x2gbfs.x2gbfs -b "${SERVER_URL}" -p "${feed}"
done
echo "All feeds created"

## TODO Sync data
echo "Syncing data ..."
rclone sync --fast-list --progress 'out' 'TODO'

