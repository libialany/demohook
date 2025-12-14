#!/bin/bash

# Define the valid Environment values
VALID_ENVIRONMENTS=("dev" "qa" "prod")

# Function to check if a string is in the list of valid environments
is_valid_environment() {
  local env=$1
  for valid_env in "${VALID_ENVIRONMENTS[@]}"; do
    if [[ "$env" == "$valid_env" ]]; then
      return 0  # Valid environment found
    fi
  done
  return 1  # Invalid environment
}
# Search for the tags block in all .tf and .tfvars files
find . -type f \( -name "*.tfvars" \) | while read -r file; do
  if grep -q 'tags = {' "$file"; then
    # Check if the file contains the Environment attribute
    ENV_VALUE=$(grep -o 'Environment\s*=\s*"[^"]*"' "$file" | sed 's/Environment\s*=\s*"\([^"]*\)"/\1/')
    if [ -z "$ENV_VALUE" ]; then
      echo "Error: 'Environment' attribute not found or is empty in 'tags' block in file $file"
      # Exit with an error code (1) to indicate that the script has failed
      # This will prevent the script from continuing to execute if an error is found
      # in one of the .tf or .tfvars files being processed.
    fi

    # Check if the Environment value is valid
    if ! is_valid_environment "$ENV_VALUE"; then
      echo "Error: 'Environment' attribute must be 'dev', 'qa', or 'prod' in file $file (found '$ENV_VALUE')"
      exit 1
    fi

    # Check if the file contains the AssetId attribute
    ASSET_ID_VALUE=$(grep -o 'AssetId\s*=\s*"[^"]*"' "$file" | sed 's/AssetId\s*=\s*"\([^"]*\)"/\1/')
    if [ -z "$ASSET_ID_VALUE" ]; then
      echo "Error: 'AssetId' attribute not found or is empty in 'tags' block in file $file"
      exit 1
    fi
  fi
done
if [ $? -eq 0 ]; then
  echo "Success: All .tf and .tfvars files have been processed successfully"
  exit 0
fi
