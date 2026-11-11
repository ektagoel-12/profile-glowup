#!/usr/bin/env bash
# Scan a clone for common problems. Never prints secret values.
# Usage: security-scan.sh <repo-dir>
set -uo pipefail
D="${1:?repo dir}"; cd "$D" || exit 1
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "not a git repo" >&2; exit 1; }
F=$(git ls-files)
out(){ printf '%s\t%s\t%s\n' "$1" "$2" "$3"; }   # severity<TAB>file<TAB>issue

# tracked env files (examples are fine)
echo "$F" | grep -E '(^|/)\.env(\.[a-z]+)?$' | grep -vE '\.(example|sample|template)$' | while read -r f; do out HIGH "$f" "tracked env file"; done
# private keys / cert files
echo "$F" | grep -E '\.(pem|p12|pfx|jks|keystore)$|(^|/)id_(rsa|ed25519)$' | while read -r f; do out HIGH "$f" "key or certificate file tracked"; done
# secret-looking assignments (value redacted, lines only)
PAT='(api[_-]?key|apikey|secret|token|passwd|password|client[_-]?secret)[[:space:]]*[:=][[:space:]]*["'"'"'][A-Za-z0-9_\-\/+=\.]{16,}["'"'"']|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{30,}|sk-[A-Za-z0-9]{20,}|AIza[0-9A-Za-z_\-]{30,}|xox[baprs]-[A-Za-z0-9-]{10,}'
echo "$F" | grep -vE '\.(png|jpe?g|webp|gif|ico|jar|bin|sqlite3|lock|pdf|mp4|ipynb)$|package-lock|bun\.lock|\.example$' | while read -r f; do
  [ -f "$f" ] || continue
  n=$(grep -ElIi "$PAT" "$f" 2>/dev/null | wc -l | tr -d ' ')
  [ "$n" -gt 0 ] && out HIGH "$f:$(grep -EnIi "$PAT" "$f" | head -1 | cut -d: -f1)" "possible hardcoded secret (value hidden)"
done
# generated data committed
echo "$F" | grep -E '(^|/)(node_modules|\.venv|venv|__pycache__|build|dist)/' | head -1 | while read -r f; do out MED "$f" "dependency/build output tracked"; done
echo "$F" | grep -E '\.(sqlite3?|db)$|chroma|vectorstore' | head -3 | while read -r f; do out MED "$f" "database or vector store tracked"; done
# .gitignore sanity
if [ ! -f .gitignore ]; then out MED ".gitignore" "missing"
elif ! grep -qE '^\.env' .gitignore; then out MED ".gitignore" "does not ignore .env"
elif LC_ALL=C grep -q $'^@"\|Out-File' .gitignore; then out MED ".gitignore" "contains script text, likely broken"
fi
exit 0
