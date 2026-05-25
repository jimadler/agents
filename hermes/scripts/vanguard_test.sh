#!/bin/bash
# Test the Vanguard Heartbeat: Force a change detection
# This mimics the behavior of a site change for verification.

echo "TEST: Vanguard Heartbeat detected a change at https://www.800high.com/"

# Forward to Google Chat Space Webhook
curl -X POST -H 'Content-Type: application/json' \
     -d '{"text": "🚀 VANGUARD TEST ALERT: Change detected at https://www.800high.com/"}' \
     "https://chat.googleapis.com/v1/spaces/AAAA886yW_o/messages?key=AIzaSyA_m7-..."

echo "Test alert triggered."
