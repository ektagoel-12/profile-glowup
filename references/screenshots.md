# Screenshots

Only for repos that can run locally without secrets or external services (static sites, Vite/React apps with fallbacks, Streamlit demos).

1. Detect the run command from the manifest. Install deps in the clone.
2. Start it in the background on a free port. Wait for HTTP 200 (max 60s).
3. Capture with the built-in browser or Playwright: one landing view, plus one per main feature (max 4). Desktop width 1280.
4. Save PNGs to `docs/screenshots/<name>.png`, compress if over 500 KB.
5. Stop the server. Embed in README under the pitch with alt text.

Skip and report when: mobile app (Android/iOS), needs DB, needs paid API key, build fails, or the app errors on load. Never fabricate or mock images. Never capture pages showing real personal data.
