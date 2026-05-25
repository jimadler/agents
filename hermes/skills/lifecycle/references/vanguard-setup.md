# Vanguard Monitoring

The Vanguard system uses a minimal `curl` heartbeat script (`vanguard_heartbeat.sh`) to detect changes on target websites.

## Setup
1. **Define targets**: Create a `targets.txt` file in your project directory containing the URLs to monitor.
2. **Configure Webhook**: Embed your Google Chat webhook URL into the `WEBHOOK_URL` variable inside `vanguard_heartbeat.sh`.
3. **Register Cron Job**: Use `hermes cron` to trigger the script at regular intervals (e.g., every 6 hours):
   `cronjob(action='create', name='vanguard-heartbeat', schedule='every 6h', script='vanguard_heartbeat.sh', prompt='Run Vanguard script. Notify if CHANGE_DETECTED.')`

## Pitfalls
- **Bot Detection**: Do not use aggressive scrapers. Stick to low-frequency `curl` requests to remain non-adversarial and invisible to anti-bot systems.
- **Webhook Validity**: Always verify the full `key` and `token` parameters of your Google Chat webhook URL if requests fail (400 errors).
