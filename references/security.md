# Security scan

`scripts/security-scan.sh <clone>` prints tab-separated `SEVERITY  file  issue`. Values are never printed.

Checks: tracked `.env`, key/cert files, secret-looking strings (generic keys, AWS, GitHub, OpenAI-style, Google, Slack), tracked build output, tracked databases or vector stores, missing or broken `.gitignore`.

## Handling findings
1. Report in the final table. Name file and line, never the value.
2. Tell the user to **revoke and rotate** any exposed key first. Deleting it from the repo does not remove it from git history or from forks and caches.
3. Do not rewrite history or force-push unless the user asks.
4. Offer a follow-up PR that moves the secret to env/config and fixes `.gitignore`. Never auto-apply.
5. Heuristic scan: false positives and misses are possible. Say so.
