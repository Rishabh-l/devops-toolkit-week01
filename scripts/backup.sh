#!/bin/bash
set -euo  pipefail
if [ $# -ne 2 ]; then
    echo "Error: Missing arguments." >&2
    echo "Usage: $0 <source_directory> <destination_directory>" >&2
    exit 1

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

SOURCE_DIR=$1
DEST_DIR=$2

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist."
    exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
    echo "Destination directory doesn't exist. Creating it..."
    mkdir -p "$DEST_DIR"
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILENAME="backup_$TIMESTAMP.tar.gz"


tar -czf "$DEST_DIR/$BACKUP_FILENAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

echo "✅ Backup successful! Saved to $DEST_DIR/$BACKUP_FILENAME"
echo "[$(date)] SUCCESS: Backup created for $SOURCE_DIR" >> backup.log
