---
name: backup
description: Backs up critical Hermes persistent data to a dated tar.gz archive.
---
# Skill: Backup

Trigger: Whenever I want to archive my agent's persistent data (memories, skills, config, etc.).

## Description
Creates a compressed `tar.gz` archive of *only* essential persistent data files and historical sessions from `~/.hermes/`. Included: `state.db`, `memories/`, `skills/`, `sessions/`, and `config.yaml`. Explicitly excludes all other files (logs, caches, framework code, `.env`, `node_modules`).

## Steps
1. Run the backup script: `~/.hermes/scripts/custom/backup.sh`.
2. Locate the dated archive in `~/Projects/agents/__data__/hermes/`.

## Pitfalls
- Uses a white-list approach; add new directories to `backup.sh` if needed.
- The `.env` file is NOT backed up; keep a separate copy.

## Verification
- Run `ls -lh ~/Projects/agents/__data__/hermes/` to check that the archive was created successfully.
