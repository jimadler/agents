# Project: Hermes Lifecycle Management
# Goal: Automate and maintain agent health, backups, and documentation.

## Phase 1: Infrastructure
- [ ] Create project root: `~/Projects/agents/hermes-lifecycle/`
- [ ] Initialize git repo in project root
- [ ] Move `~/Projects/agents/__data__/hermes/` to project root (or symlink)
- [ ] Create `.hermes/plans/PLAN.md`

## Phase 2: Automation
- [ ] Create cron job to run `~/.hermes/scripts/backup.sh` weekly
- [ ] Automate `git commit` and `git push` for backups

## Phase 3: Documentation
- [ ] Update `SKILL.md` for lifecycle management
