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


echo "--- TOP 3 IP ADDRESSES ---"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -n 3
echo ""

echo "--- TOP 3 MOST POPULAR PATHS ---"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -n 3
echo ""

echo "--- ERROR SUMMARY ---"
ERROR_COUNT=$(awk '$9 ~ /^[45]/ {print $9}' "$LOG_FILE" | wc -l)
echo "Total client/server errors (4xx/5xx): $ERROR_COUNT"
echo "==========================================="
