#!/bin/env bash

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Missing arguments, usage:"
	echo "renameregex <directory> <regex> [substitution]"
	echo "remember that you need to escape special characters"
	echo "try with \"'regex'\", for example \"'*.mp4'\""
	echo "this should work too, but it is more work: \"\*\""
	exit 1
fi

cd "$1"

for FILE in *; do
	NEW_NAME=$(sed -r "s/$2/$3/g" <<< "$FILE")
	echo "$FILE -> $NEW_NAME"
done

echo "------------------------------------"
echo "Are you ok with these changes? [y/N]"
read CONFIRMATION

if [ $CONFIRMATION == 'y' ] || [ $CONFIRMATION == 'Y' ]; then
	for FILE in *; do
		NEW_NAME=$(sed -r "s/$2/$3/g" <<< "$FILE")
		mv "$FILE" "$NEW_NAME"
		echo "$FILE -> $NEW_NAME"
	done
else
	echo "Operation aborted."
fi