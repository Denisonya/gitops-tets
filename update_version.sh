#!/bin/bash

# Script to update VERSION file based on PR label
# Usage: ./update_version.sh <version_type>
# version_type: patch, minor, major, or none

# TESTING TESTING

set -e

VERSION_FILE="VERSION"
VERSION_TYPE="${1:-none}"

if [ ! -f "$VERSION_FILE" ]; then
    echo "Error: VERSION file not found"
    exit 1
fi

CURRENT_VERSION=$(cat "$VERSION_FILE" | tr -d ' \n\r')
IFS='.' read -ra VERSION_PARTS <<< "$CURRENT_VERSION"

MAJOR="${VERSION_PARTS[0]:-0}"
MINOR="${VERSION_PARTS[1]:-0}"
PATCH="${VERSION_PARTS[2]:-0}"

case "$VERSION_TYPE" in
    patch)
        PATCH=$((PATCH + 1))
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    none)
        echo "No version update requested (version:none label)"
        exit 0
        ;;
    *)
        echo "Error: Invalid version type '$VERSION_TYPE'. Must be: patch, minor, major, or none"
        exit 1
        ;;
esac

NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"
echo "$NEW_VERSION" > "$VERSION_FILE"
echo "Version updated: $CURRENT_VERSION -> $NEW_VERSION"

