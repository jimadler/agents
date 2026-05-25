---
name: vanguard-space-search
description: Automated parsing for property listing data.
---
# Vanguard Space Search

Automated parsing for property listing data.

## Features
- Fetches HTML from URLs defined in `targets.txt`.
- Extracts core metadata (Price, SqFt, Availability) using CSS selectors.
- Updates the `intelData` object in the dashboard `index.html`.

## Usage
1. Run `python3 parse_intel.py` to scrape all targets.
2. The script parses the HTML, calculates an innovation score, and patches `index.html`.

## Pitfalls
- Requires target URLs to have consistent metadata patterns.
- High-latency sites may require increasing the `requests.get` timeout.
- Pathing: Always use site-root absolute paths (`/file.html` or `/directory/`) in HTML templates to prevent navigation loops in nested folder structures.
- Directory Structure: Keep the dashboard (`index.html`), data (`targets.txt`), and logic (`parse_intel.py`) in the same project directory to avoid pathing drift.
