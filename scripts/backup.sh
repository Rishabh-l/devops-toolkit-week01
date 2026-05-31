#!/bin/bash

# Check if both arguments (source and destination) are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

SOURCE_DIR=$1
DEST_DIR=$2

# Check if the source directory actually exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist."
    exit 1
fi

# Create destination directory if it doesn't exist yet
if [ ! -d "$DEST_DIR" ]; then
    echo "Destination directory doesn't exist. Creating it..."
    mkdir -p "$DEST_DIR"
fi

# Generate a unique timestamp (Format: YYYYMMDD_HHMMSS)
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILENAME="backup_$TIMESTAMP.tar.gz"

# Compress the source folder into the destination folder
tar -czf "$DEST_DIR/$BACKUP_FILENAME" "$SOURCE_DIR"

# Verify if the tar command succeeded (exit code 0 means success)
if [ $? -eq 0 ]; then
    echo "Backup successful! Saved to $DEST_DIR/$BACKUP_FILENAME"
else
    echo "Backup failed."
fi
