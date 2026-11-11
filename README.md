# profile-glowup

A Claude Code skill that fixes your GitHub profile: analyzes your repos, writes READMEs, and builds a portfolio site.

## What it does

1. Lists your repos and scores their health.
2. You pick which repos (or all).
3. Writes a README for each, grounded in the real code. Opens a PR per repo.
4. Optionally builds your profile README.

## Add-ons

| Flag | Fixes |
|---|---|
| `--audit-only` | Ranked fix list and recruiter-view notes, changes nothing |
| `--security` | Finds committed API keys, `.env` files, broken `.gitignore`, tracked databases |
| `--describe` | Fills empty repo descriptions and topics |
| `--license <id>` | Adds a LICENSE where missing |
| `--screenshots` | Real screenshots in the README, captured by booting the app |
| `--pin-plan` | Recommends which 6 repos to pin |
| `--portfolio-site` | Generates a GitHub Pages portfolio from your repos |
| `--config glowup.yml` | Saves defaults and per-repo overrides |

Safe by default: PR mode, no overwrites, nothing pushed without your yes.

## Install

```bash
git clone https://github.com/ektagoel-12/profile-glowup ~/.claude/skills/profile-glowup
```

Requirements: `git`, [`gh`](https://cli.github.com) (authed) or a `GITHUB_TOKEN`.

## Use

```
/profile-glowup
/profile-glowup --repos all
/profile-glowup --repos api,webapp --describe --license MIT
/profile-glowup --dry-run
```

See `SKILL.md` for all options and `references/ideas.md` for planned add-ons.

## Author

Ekta Goel ([@ektagoel-12](https://github.com/ektagoel-12))

## License

MIT
