#!/bin/sh

# Check if a search string is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <search-string>"
  exit 1
fi

# Get the search string from the argument
SEARCH_STRING="$1"
LOG_DIR="./logs"

# Create the logs directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Define log file name with date (e.g., search_2023-12-01.log)
LOG_FILE="$LOG_DIR/search_$(date +%Y%m%d%H%M%S).log"

# Search for the string in all files and capture the result
echo "Searching for '$SEARCH_STRING' in all files..." > "$LOG_FILE"
grep -rHn "$SEARCH_STRING" . >> "$LOG_FILE" 2>&1

# Check if any results were found
if [ $? -eq 0 ]; then
  # Display the files containing the string
  echo "Files containing the string '$SEARCH_STRING':"
  grep -rHl "$SEARCH_STRING" .  # This lists only the filenames containing the string
  echo "Search results have been logged to $LOG_FILE"
else
  echo "No results found for '$SEARCH_STRING'."
fi
