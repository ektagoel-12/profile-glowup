#!/usr/bin/env bash
# Report tool availability for profile-glowup. Never prints secrets.
ok(){ printf '%-14s %s\n' "$1" "$2"; }
command -v git >/dev/null && ok git yes || ok git MISSING
command -v node >/dev/null && ok node "$(node -v)" || ok node "missing (needed for brag videos)"
if command -v gh >/dev/null; then
  ok gh installed
  gh auth status >/dev/null 2>&1 && ok gh-auth yes || ok gh-auth "no (run: gh auth login)"
else
  ok gh "missing (install: https://cli.github.com)"
fi
[ -n "${GITHUB_TOKEN:-}" ] && ok GITHUB_TOKEN set || ok GITHUB_TOKEN unset
if [ -f "$HOME/.claude/skills/brag/SKILL.md" ] || ls "$HOME"/.claude/plugins/*/skills/brag/SKILL.md >/dev/null 2>&1; then
  ok brag-skill found
else
  ok brag-skill "missing (videos unavailable)"
fi
