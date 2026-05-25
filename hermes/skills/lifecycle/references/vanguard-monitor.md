# Vanguard Monitor System
- Target File: `~/Projects/agents/hermes/projects/vanguard-space-search/targets.txt`
- Monitoring Script: `~/.hermes/scripts/custom/vanguard_heartbeat.sh`
- Notifications: Pushed via Webhook to the shared Google Chat space.
- Maintenance: To add a new building, append the URL to `targets.txt`. The script picks it up automatically on the next heartbeat (every 6h).
- Verification: If no notification is received, verify space membership and webhook health.
