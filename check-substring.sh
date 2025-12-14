#!/bin/sh
s=$(grep -r --include="*.tfvars" --include="*.tf" "tag*" "$(pwd)")
if [ -z "$s" ]; then
    echo ":("
    exit 0
else
    echo "wii $s"
fi

