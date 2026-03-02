#!/bin/sh

## run_all.sh
#
# Usage:
#
# Set environment variables: SERVER_URL TARGET_PATH
# Also set all environment variable to run Rclone (see below)
#
# Pass all configuration file names to process
# Example: cambio_aachen cambio_bielefeld cambio_dortmund
#

if [ -z "${SERVER_URL}" ]; then
	echo "ERROR: SERVER_URL is not set. Aborting." >&2
	exit 2
fi
if [ -z "${TARGET_PATH}" ]; then
	echo "ERROR: TARGET_PATH is not set. Aborting." >&2
	exit 2
fi
# Variables for Rclone
missing=''
[ -n "${RCLONE_CONFIG_S3_ENDPOINT}" ] || missing="${missing} RCLONE_CONFIG_S3_ENDPOINT"
[ -n "${RCLONE_CONFIG_S3_PROVIDER}" ] || missing="${missing} RCLONE_CONFIG_S3_PROVIDER"
[ -n "${RCLONE_CONFIG_S3_REGION}" ] || missing="${missing} RCLONE_CONFIG_S3_REGION"
[ -n "${RCLONE_CONFIG_S3_TYPE}" ] || missing="${missing} RCLONE_CONFIG_S3_TYPE"
[ -n "${RCLONE_CONFIG_S3_ENV_AUTH}" ] || missing="${missing} RCLONE_CONFIG_S3_ENV_AUTH"
[ -n "${RCLONE_CONFIG_S3_ACL}" ] || missing="${missing} RCLONE_CONFIG_S3_ACL"
[ -n "${AWS_ACCESS_KEY_ID}" ] || missing="${missing} AWS_ACCESS_KEY_ID"
[ -n "${AWS_SECRET_ACCESS_KEY}" ] || missing="${missing} AWS_SECRET_ACCESS_KEY"
if [ -n "${missing}" ]; then
	echo "ERROR: Missing Rclone configuration variable:${missing}. Aborting." >&2
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
python -m x2gbfs.x2gbfs -b "${SERVER_URL}" -p "${*// /,}"
echo "All feeds created"

## TODO Sync data
echo "Syncing data ..."
rclone sync --fast-list --progress 'out' "${TARGET_PATH}"

