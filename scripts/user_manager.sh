#!/bin/bash
if [ -z  "$1" ]; then
	echo "Wheres the file  bro?"
	exit 1
fi
CSV_FILE=$1
if [ ! -f "$CSV_FILE" ]; then 
	echo "File not found in your pc"
	exit 1
fi
while IFS="," read -r USERNAME ACTION || [ -n "$USERNAME" ]; do
	if [ "$USERNAME" = "username" ]; then 
		continue
	fi
	USERNAME=$(echo "$USERNAME" | xargs)
    	ACTION=$(echo "$ACTION" | xargs)
	if [ "$ACTION" = "create" ]; then 
		echo "Processing: Creating user '$USERNAME'..."
		sudo useradd -m "$USERNAME"
	elif [ "$ACTION" == "delete" ]; then
        	echo "Processing: Deleting user '$USERNAME'..."
		sudo userdel -r "$USERNAME"
	else
        echo "Warning: Unknown action '$ACTION' encountered for user '$USERNAME'"
    	fi
done < "$CSV_FILE"
