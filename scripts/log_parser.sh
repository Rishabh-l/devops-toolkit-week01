#!/bin/bash
set -euo pipefail
if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_access.log>"
    exit 1
fi

LOG_FILE=$1


if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File $LOG_FILE not found."
    exit 1
fi

echo "==========================================="
echo "        DEVOPS LOG ANALYSIS REPORT         "
echo "==========================================="
echo ""


echo "--- TOP 10 IP ADDRESSES ---"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -n 10
echo ""

echo "--- TOP 10 MOST POPULAR PATHS ---"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -n 10
echo ""

echo "--- ERROR SUMMARY ---"
ERROR_COUNT=$(cat "$LOG_FILE" | awk '$9 ~ /^[45]/ {print $9}' | wc -l | xargs)
echo "Total client/server errors (4xx/5xx): $ERROR_COUNT"
echo "==========================================="
