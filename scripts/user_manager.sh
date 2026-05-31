#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 2 ]; then
    echo "Error: Missing arguments." >&2
    echo "Usage: $0 <action: create|delete> <csv-file>" >&2
    exit 1
fi

ACTION="$1"
CSV_FILE="$2"

if [ ! -f "$CSV_FILE" ]; then
    echo "Error: Input CSV file not found: $CSV_FILE" >&2
    exit 1
fi

process_users() {
    tail -n +2 "$CSV_FILE" | while IFS=, read -r USERNAME PASSWORD || [ -n "$USERNAME" ]; do
        USERNAME=$(echo "$USERNAME" | tr -d '\r' | xargs)
        PASSWORD=$(echo "$PASSWORD" | tr -d '\r' | xargs)

        [ -z "$USERNAME" ] && continue

        if [ "$ACTION" == "create" ]; then
            if id "$USERNAME" &>/dev/null; then
                echo "ℹ️  Skipping: User '$USERNAME' already exists on this machine."
            else
                sudo useradd -m -p "$(openssl passwd -1 "$PASSWORD")" "$USERNAME"
                echo "✅ Successfully created user: $USERNAME"
            fi
        elif [ "$ACTION" == "delete" ]; then
            if id "$USERNAME" &>/dev/null; then
                sudo userdel -r "$USERNAME"
                echo "🗑️  Successfully deleted user: $USERNAME"
            else
                echo "ℹ️  Skipping: User '$USERNAME' does not exist."
            fi
        fi
    done
}

process_users
