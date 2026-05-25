# Vanguard Infrastructure Notes

- Dashboard: Hosted at port 8000 via `python3 -m http.server`.
- Webhooks: Uses Google Chat via `vanguard_heartbeat.sh`.
- Pathing Convention: All inter-page links and data fetches use site-root absolute paths (`/`) to ensure stability.
- Automation: Heartbeat (every 6h) and Intel Parser (every 6h) run via system-level cron.
