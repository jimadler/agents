# Vanguard Reconnaissance Protocol

## Rules for Intel Dashboards
1. **Static-First**: Avoid dynamic `fetch()` calls for critical data (targets, status scores). JavaScript parsing is fragile, prone to CORS/CORS/CORS errors, and difficult to debug in the headless environment.
2. **Hard-Coded Updates**: Update data directly in the source code (the `intelData` map or the HTML structure) and rely on the agent to perform these updates. This ensures the dashboard is *always* available and accurate without runtime errors.
3. **Verification**: Before updating an Intel Station with a target property, use a reliable verification (e.g., direct navigation or curl) to ensure the URL is active. Never add unverified targets.
4. **Formatting**: Use a `Name|URL` format in `targets.txt` files and parse strictly with a filter (`line.trim() && !line.startsWith('#')`) to avoid errors from comments or header rows.
5. **Sidebar Integrity**: When maintaining master dashboards (`index.html`), always preserve the existing layout structure (sidebar navigation, persistent styling). Avoid destructive edits that lose the visual navigation.
