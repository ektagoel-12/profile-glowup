# profile-glowup

A Claude Code skill that fixes your GitHub profile: analyzes your repos, writes READMEs, and makes a launch video for the projects you pick.

## What it does

1. Lists your repos and scores their health.
2. You pick which repos (or all).
3. Writes a README for each, grounded in the real code. Opens a PR per repo.
4. Optionally makes a short brag video per project using the `brag` skill.
5. Optionally builds your profile README.

## Add-ons

| Flag | Fixes |
|---|---|
| `--audit-only` | Ranked fix list and recruiter-view notes, changes nothing |
| `--security` | Finds committed API keys, `.env` files, broken `.gitignore`, tracked databases |
| `--describe` | Fills empty repo descriptions and topics |
| `--license <id>` | Adds a LICENSE where missing |
| `--screenshots` | Real screenshots in the README, captured by booting the app |
| `--video-hosting release` | Hosts brag videos as release assets and links them in the README |
| `--pin-plan` | Recommends which 6 repos to pin |
| `--portfolio-site` | Generates a GitHub Pages portfolio from your repos |
| `--config glowup.yml` | Saves defaults and per-repo overrides |

Safe by default: PR mode, no overwrites, nothing pushed without your yes.

## Install

```bash
git clone https://github.com/ektagoel-12/profile-glowup ~/.claude/skills/profile-glowup
```

Requirements: `git`, [`gh`](https://cli.github.com) (authed) or a `GITHUB_TOKEN`. For videos: the third-party `brag` skill (see Credits) and Node.

## Use

```
/profile-glowup
/profile-glowup --repos all --video none
/profile-glowup --repos api,webapp --video webapp --tone polished
/profile-glowup --dry-run
```

See `SKILL.md` for all options and `references/ideas.md` for planned add-ons.

## Credits and third-party dependencies

The video feature uses **`brag`, a separate skill made by someone else**. It is not part of this repo and is not bundled. `profile-glowup` only calls it when you ask for videos. Install it from its original author's repository: <!-- TODO: add the brag repo URL here -->

`brag` is built on Hyperframes and ships its own assets (including music tracks) under its own terms. All credit for the video generation goes to its authors; check its license before sharing videos publicly.

Without `brag`, everything else in `profile-glowup` still works.

## License

MIT (applies to this repo only, not to `brag`)
