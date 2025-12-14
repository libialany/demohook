#!/bin/sh

# Check if the user provided a search string
if [ -z "$1" ]; then
  echo "Usage: $0 <search-string>"
  exit 1
fi

# Get the search string from the first argument
SEARCH_STRING="tag*"

# Search for the string in .tfvars and .tf files in the current directory and subdirectories
grep -r --include="*.tfvars" --include="*.tf" "$SEARCH_STRING" "$(pwd)"
