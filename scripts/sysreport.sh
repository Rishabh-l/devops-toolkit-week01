#!/bin/bash

echo "========================================="
echo "        SYSTEM HEALTH REPORT             "
echo "        Date: $(date)"
echo "========================================="
echo ""

echo "--- DISK SPACE USAGE ---"
df -h /
echo ""


DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')


if [ "$DISK_USAGE" -ge 95 ]; then
    echo "⚠️  WARNING: CRITICAL DISK SPACE! Available space is below 5% (Current Usage: ${DISK_USAGE}%)."
else
    echo "✅ Disk space health is optimal (Current Usage: ${DISK_USAGE}%)."
fi

echo ""
echo "--- MEMORY (RAM) USAGE ---"
free -m

echo ""
echo "--- TOP 5 CPU CONSUMING PROCESSES ---"
ps aux --sort=-%cpu | head -n 6

echo "========================================="
