#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if SSH agent is already running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  echo "SSH agent not running"
  exit 1
fi

# Define an array of key paths relative to the script directory
KEYS=(
  "/path/to/key"
  "/path/to/key2"
)

# Add each key to the SSH agent
for relative_key in "${KEYS[@]}"; do
  absolute_key="${SCRIPT_DIR}/${relative_key}"
  if [ -f "$absolute_key" ]; then
    echo "Adding key: $absolute_key"
    ssh-add "$absolute_key"
  else
    echo "Key not found: $absolute_key"
  fi
done
