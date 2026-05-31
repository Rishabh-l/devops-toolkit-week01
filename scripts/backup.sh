#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 2 ]; then
    echo "Error: Missing arguments." >&2
    echo "Usage: $0 <source_directory> <destination_directory>" >&2
    exit 1
fi

SOURCE_DIR="$1"
DEST_DIR="$2"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist." >&2
    exit 1
fi

mkdir -p "$DEST_DIR"

BACKUP_FILENAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

echo "📦 Archiving contents of $SOURCE_DIR..."

tar -czf "$DEST_DIR/$BACKUP_FILENAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

echo "✅ Backup successful! Saved to $DEST_DIR/$BACKUP_FILENAME"
echo "[$(date)] SUCCESS: Backup created for $SOURCE_DIR" >> "$DEST_DIR/backup.log"
