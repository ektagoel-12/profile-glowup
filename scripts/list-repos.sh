#!/usr/bin/env bash
# List a user's own repos as JSON. Usage: list-repos.sh [username]
# Uses gh if authed, else GITHUB_TOKEN via REST, else unauthenticated public API.
set -euo pipefail
USER_ARG="${1:-}"
if command -v gh >/dev/null && gh auth status >/dev/null 2>&1; then
  FIELDS=name,description,primaryLanguage,stargazerCount,pushedAt,diskUsage,isFork,isArchived,url,licenseInfo,repositoryTopics,owner
  if [ -n "$USER_ARG" ]; then
    LIST=$(gh repo list "$USER_ARG" --limit 200 --source --no-archived --json "$FIELDS")
  else
    LIST=$(gh repo list --limit 200 --source --no-archived --json "$FIELDS")
  fi
  # add hasReadme + readmeBytes per repo (404 = no README, silenced)
  echo "$LIST" | python3 -I -c '
import json,subprocess,sys
repos=json.load(sys.stdin)
for r in repos:
    full=r["owner"]["login"]+"/"+r["name"]
    p=subprocess.run(["gh","api","repos/"+full+"/readme","-q",".size"],capture_output=True,text=True)
    ok=p.returncode==0 and p.stdout.strip().isdigit()
    r["hasReadme"]=ok
    r["readmeBytes"]=int(p.stdout.strip()) if ok else 0
print(json.dumps(repos,indent=1))
'
  exit 0
fi
[ -n "$USER_ARG" ] || { echo "No gh auth. Pass a username." >&2; exit 1; }
AUTH_HDR="Accept: application/vnd.github+json"
if [ -n "${GITHUB_TOKEN:-}" ]; then
  curl_auth() { curl -fsSL -H "Authorization: Bearer $GITHUB_TOKEN" "$@"; }
else
  curl_auth() { curl -fsSL "$@"; }
fi
curl_auth -H "$AUTH_HDR" \
  "https://api.github.com/users/$USER_ARG/repos?per_page=100&type=owner&sort=pushed" \
  | python3 -I -c '
import json,sys
for r in json.load(sys.stdin):
    if r["fork"] or r["archived"]: continue
    print(json.dumps({k:r.get(k) for k in ("name","description","language","stargazers_count","pushed_at","size","license","topics","html_url")}))
'
