#!/bin/bash
# Backup Hermes data to ~/Projects/agents/__data__/hermes/
# Explicitly includes core persistence and history, excludes transient overhead.
# $ ~/.hermes/scripts/custom/backup.sh

DEST_DIR="$HOME/Projects/agents/__data__/hermes"
BACKUP_FILE="$DEST_DIR/$(date +%Y%m%d_%H%M%S).tar.gz"

echo "Creating Hermes backup in $BACKUP_FILE..."
mkdir -p "$DEST_DIR"

# Explicit inclusion of core data and history
tar -czvf "$BACKUP_FILE" \
  -C "$HOME/.hermes" \
  config.yaml \
  cron/ \
  memories/ \
  scripts/ \
  skills/ \
  sessions/ \
  state.db

# Copy a few files to keep them under source control
cp $HOME/.hermes/SOUL.md $HOME/Projects/agents/hermes/dot-hermes/SOUL.md
cp $HOME/.hermes/config.yaml $HOME/Projects/agents/hermes/dot-hermes/config.yaml

echo "Backup complete."
