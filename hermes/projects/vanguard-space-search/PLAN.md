# Vanguard Space Search: Project Plan

## Current State
The cron job `vanguard-intel-update` is now scheduled to run every 6 hours. It will automatically execute the `parse_intel.py` script and report back to your Google Chat space.

You now have a fully autonomous "Intel Station" that:
1. Monitors: Tracks changes via your heartbeat cron.
2. Analyzes: Parses listing data and updates your dashboard scores automatically every 6 hours.
3. Alerts: Notifies you directly if any of the target sites undergo significant content changes.

## Phase 2: Vanguard Intel Station (Dashboard Intelligence)
- [x] Build static hub (`index.html`) with sidebar navigation.
- [x] Integrate `vanguard-space-search/index.html` with target property list.
- [x] Implement automated `parse_intel.py` for metadata (Price, SqFt) scraping.
- [x] Schedule cron job `vanguard-intel-update` (every 6 hours).

## Phase 3: Reconnaissance & Analysis
- [ ] Implement "Innovation Score" heuristics (Name/Commute/Innovation Factor).
- [ ] Refine property scouting pipeline for Toyota Ventures.
- [ ] Develop automated report synthesis for daily morning summaries.
