#!/bin/bash
#Modified from https://github.com/docker-library/logstash/blob/bb4f8b0d3f3e92a04dfbfee1d2b94196f64bd78c/5.0/docker-entrypoint.sh
set -e

# Add logstash as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- logstash "$@"
fi

#Don't set user as logstash to allow for it to be explicitly set
# with --user
#if [ "$1" = 'logstash' ]; then
#	set -- gosu logstash "$@"
#fi

exec "$@"
