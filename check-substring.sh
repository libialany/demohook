#!/bin/sh

# Check if a search string is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <search-string>"
  exit 1
fi

# Get the search string from the argument
SEARCH_STRING="$1"

# Search for the string in all .tf and .tfvars files
MATCHING_FILES=$(grep -rl --include="*.tf" --include="*.tfvars" "$SEARCH_STRING" .)

# Check if any matching files were found
if [ -z "$MATCHING_FILES" ]; then
  echo "No files found containing the string '$SEARCH_STRING'."
else
  echo "Files containing the string '$SEARCH_STRING':"
  echo "$MATCHING_FILES"
fi
