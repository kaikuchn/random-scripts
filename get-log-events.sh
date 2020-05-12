#!/usr/bin/env bash

set -uo pipefail

command_available() {
    command -v $1 >/dev/null 2>&1 || { echo >&2 "Please make sure $1 is installed."; exit 1; }
}

usage() {
    echo "usage: [-? | --help] --log-group LOG_GROUP [--stream-prefix STREAM_PREFIX] [--filter FILTER] [--start START_TIME] [--end END_TIME]"
    echo " "
    echo "Fetch log events from LOG_GROUP."
    echo " "
    echo "required:"
    echo "--log-group           name of the log-group"
    echo " "
    echo "options:"
    echo "-?, --help            display this help"
    echo "--stream-prefix       fetch log events only from streams that start with STREAM_PREFIX"
    echo "--filter              filter log events according to the provided pattern"
    echo "--start               fetch log events that are newer than START_TIME only"
    echo "--end                 fetch log events that are older than END_TIME only"
}

if [ $# -eq 0 ]; then
    usage
    exit 0
fi

command_available aws
command_available jq

while test $# -gt 0; do
    case "$1" in
        -\?|--help)
            usage
            exit 0
            ;;
        --log-group)
            shift
            if [ $# -gt 0 ]; then
                log_group="$1"
            else
                echo "No log group specified"
                exit 1
            fi
            shift
            ;;
        --log-group=*)
            log_group="$(echo $1 | sed -e 's/^[^=]*=//g')"
            shift
            ;;
        --stream-prefix)
            shift
            if [ $# -gt 0 ]; then
                stream_prefix="$1"
            else
                echo "No stream prefix specified"
                exit 1
            fi
            shift
            ;;
        --stream-prefix=*)
            stream_prefix="$(echo $1 | sed -e 's/^[^=]*=//g')"
            shift
            ;;
        --filter)
            shift
            if [ $# -gt 0 ]; then
                filter="$1"
            else
                echo "No filter specified"
                exit 1
            fi
            shift
            ;;
        --filter=*)
            filter="$(echo $1 | sed -e 's/^[^=]*=//g')"
            shift
            ;;
        --start)
            shift
            if [ $# -gt 0 ]; then
                start_time="$1"
            else
                echo "No start time specified"
                exit 1
            fi
            shift
            ;;
        --start=*)
            start_time="$(echo $1 | sed -e 's/^[^=]*=//g')"
            shift
            ;;
        --end)
            shift
            if [ $# -gt 0 ]; then
                end_time="$1"
            else
                echo "No end time specified"
                exit 1
            fi
            shift
            ;;
        --end=*)
            end_time="$(echo $1 | sed -e 's/^[^=]*=//g')"
            shift
            ;;
    esac
done

if [[ -z "${log_group:-}" ]]; then
    echo "Log group must be specified."
    echo ""
    usage
    exit 0
fi

declare -a options
if [[ -n "${stream_prefix:-}" ]]; then
    options+=("--log-stream-name-prefix" "${stream_prefix}")
fi

if [[ -n "${filter:-}" ]]; then
    options+=("--filter-pattern" "${filter}")
fi

if [[ -n "${start_time:-}" ]]; then
    options+=("--start-time" "${start_time}")
fi

if [[ -n "${end_time:-}" ]]; then
    options+=("--end-time" "${end_time}")
fi

result=$(aws logs filter-log-events --max-items 1000 --log-group-name "${log_group}" "${options[@]}")
echo $result | jq -rc '.events[]'

next_token=$(echo $result | jq -r '.NextToken // empty')
while [[ -n "${next_token}" ]]; do
    result=$(aws logs filter-log-events --max-items 1000 --log-group-name "${log_group}" "${options[@]}" --starting-token "${next_token}")
    echo $result | jq -rc '.events[]'

    next_token=$(echo $result | jq -r '.NextToken // empty')
done
