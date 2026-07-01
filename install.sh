#!/usr/bin/env bash
# Usage: ./install.sh /path/to/your/obsidian/vault
set -e

VAULT="${1:?Usage: $0 /path/to/vault}"
THEME_NAME="Apatheia-Light"
DEST="$VAULT/.obsidian/themes/$THEME_NAME"

mkdir -p "$DEST"
cp theme.css manifest.json "$DEST/"

echo "Installed $THEME_NAME to $DEST"
