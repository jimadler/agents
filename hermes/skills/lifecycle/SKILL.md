---
name: lifecycle
description: "Manage the Hermes lifecycle: backups, planning, and state management."
---
# Skill: Hermes Lifecycle Management

Trigger: When initiating projects or performing maintenance on Hermes's persistent state.

## Description
This skill wraps the lifecycle management of the Hermes Agent, including archiving data (backups) and initializing new projects (planning).

### User Preferences (Identity Governance)
- When initiating projects or major workstreams, always load the `governance` skill to ingest `VALUES.md`, `BOUNDARIES.md`, `TONE.md`, and `EXPECTATIONS.md`.
- Ensure all actions are challenged against mission alignment, velocity, and the "weirdness" factor.
- Default project structure: `~/Projects/agents/hermes/projects/<project>/`.

### Procedures
1. **Backup**: Run `~/.hermes/scripts/backup.sh` to archive state (memories, skills, history).
2. **Project Initiation**: Use `hermes plan` to create a `PLAN.md` for new initiatives.
3. **Data Organization**: Store project data in `~/Projects/agents/hermes/projects/<project>/`.
4. **Dashboarding**: Use `python3 -m http.server 8000 --directory /Users/jim/Projects/agents/hermes/` and `ngrok` for external access.

## Pitfalls
- **Multi-Tunnel Limit**: If you have multiple `ngrok` tunnels (e.g., Dashboard + VNC), ensure your `ngrok.yml` auth token is a paid-tier token to avoid `ERR_NGROK_108`.
- **Web server routing**: If you have a root `index.html` hub, ensure it is served correctly. If it shows 404, check directory binding or use a simple `redirect` file.
- **Webhook Authentication**: When setting up alerts to Google Chat spaces via webhooks, use the full authenticated URL format provided by the Google Chat API.
- **Bot/Space Integration**: Google Chat Spaces cannot be joined by the agent as a user; use Google Chat Webhooks for Space-based alerts.
- **Bot/Space Integration**: Google Chat Spaces cannot be joined by the agent as a user; use Google Chat Webhooks for Space-based alerts.

## Verification
- Run `ls -lt ~/Projects/agents/hermes/__data__/` to verify the latest backup.
- Run `cat ~/Projects/agents/hermes/projects/<project>/index.html` to check project dashboard.

## References
- Vanguard Recon Protocol: `references/vanguard_protocol.md` - Verification, sync, and static-first rules for reconnaissance.
