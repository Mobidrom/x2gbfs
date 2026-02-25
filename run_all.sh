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

