---
name: profile-glowup
description: Fix up a GitHub profile. Analyzes the user's repos, lets them pick which (or all), writes a README for each, opens PRs with them. Use when someone says "/profile-glowup", "fix my github profile", "add READMEs to my repos", "polish my GitHub", or "make my projects look good".
---

# /profile-glowup

Turn a messy GitHub profile into a portfolio. Analyze repos, write READMEs, tidy the profile.

## Options

| Option | Values | Default |
|---|---|---|
| `--repos` | `all`, or comma list of repo names | ask user |
| `--readme` | `on`, `off` | on |
| `--mode` | `pr` (open PR), `push` (commit to default branch), `local` (files only) | `pr` |
| `--overwrite` | flag: replace existing READMEs | off (improve only if weak) |
| `--profile-readme` | flag: also build `<user>/<user>` profile README | off |
| `--dry-run` | flag: analyze and report, change nothing | off |
| `--workdir` | clone location | `./profile-glowup-work` |
| `--audit-only` | flag: score all repos, ranked fix list, change nothing | off |
| `--security` | `off`, `scan` (report only) | `scan` |
| `--describe` | flag: propose repo descriptions and topics, apply on confirm | off |
| `--license` | SPDX id (`MIT`, `Apache-2.0`, ...) to add where missing | off |
| `--screenshots` | flag: boot the app, capture real screenshots, embed in README | off |
| `--pin-plan` | flag: recommend the 6 repos to pin | off |
| `--portfolio-site` | flag: generate a GitHub Pages portfolio from analyzed repos | off |
| `--config` | path to `glowup.yml` with saved defaults | `./glowup.yml` if present |

Flags override `glowup.yml`, which overrides defaults. See [references/config.md](references/config.md).

Natural language works too ("fix my 3 best repos").

## Safety rules (hard)

- Never push to a default branch unless `--mode push` AND the user confirmed in chat this run.
- Never overwrite an existing README unless `--overwrite` or user approves that repo. Show a diff first.
- Never touch forks, archived repos, or repos the user does not own unless user names them.
- Never print or store tokens. Read auth from `gh` or `GITHUB_TOKEN` only.
- Always show the final plan (repo → actions) and wait for a yes before any write or push.
- Do not invent features. Every README claim must come from code, config, or existing docs.

## Step 0: Preflight

Run `bash <skill-dir>/scripts/preflight.sh`. It reports: `gh` installed and authed, `git`, and `node`.

- No `gh`: fall back to the REST API with `GITHUB_TOKEN` (see [references/github-api.md](references/github-api.md)). No token either: ask the user for their GitHub username and run in public read-only mode, `--mode local` forced.

## Step 1: Discover repos

Run `bash <skill-dir>/scripts/list-repos.sh [username]`. It prints JSON: name, description, language, stars, pushed date, size, fork, archived, has README, README length.

Drop forks and archived repos by default. Show a numbered table with a health score from [references/analysis.md](references/analysis.md) (README missing/weak, no description, no topics, no license, stale).

**`--audit-only`:** stop after this step plus the security scan. Output a ranked fix list (worst health and most recent activity first), a recruiter-view note (what a hiring manager sees in 30 seconds, top 5 fixes), and the `--pin-plan` if requested. Change nothing.

Ask the user: which repos? (`all`, numbers, or names).

## Step 2: Analyze each chosen repo

Shallow-clone into `--workdir` (`git clone --depth 1`). Follow [references/analysis.md](references/analysis.md) to extract: purpose, stack, entry points, install/run commands, env vars, screenshots or demo assets, tests, license, deploy hints.

For big repos, delegate each repo to a subagent in parallel (max 4). Each returns a compact JSON profile, not file dumps.

Unless `--security off`, run `bash <skill-dir>/scripts/security-scan.sh <clone>` on each clone (see [references/security.md](references/security.md)). Findings go in the report. Never print secret values, never put them in a README or PR. Never auto-fix: tell the user to revoke the key first.

Record unknowns as unknowns. Ask the user only for facts code cannot give (live demo URL, project motivation).

## Step 3: Write READMEs

Follow [references/readme-guide.md](references/readme-guide.md) and the templates in [references/readme-template.md](references/readme-template.md). Pick template by project type (web app, CLI, library, data/ML, other).

Rules:
- Lead with one-line pitch, then what it does and how to run it.
- Commands must be copied from real scripts (`package.json`, `Makefile`, `pyproject.toml`). Verify they exist.
- Badges only for things that are true (license file present, CI workflow present).
- Existing README: keep author voice and unique content, restructure and fill gaps.

With `--screenshots`: follow [references/screenshots.md](references/screenshots.md) to boot the app and capture real images into `docs/screenshots/`. Embed only images that were actually captured. If the app cannot boot (missing keys, mobile app, needs DB), skip and say why. Never fake or mock a screenshot.

Write to `<repo>/README.md` in the clone. Show the user a diff or preview for each repo before step 4.

## Step 4: Apply

Show the plan: repo → README action, topics/description suggestions, mode. Wait for explicit yes.

- `pr` mode: branch `docs/profile-glowup-readme`, commit, push, `gh pr create --head docs/profile-glowup-readme`. Before committing, set a repo-local git identity if none is configured: name = GitHub login, email = `<id>+<login>@users.noreply.github.com` (from `gh api user`). Never let git fall back to the machine hostname email. PR body: what changed and why, no marketing fluff.
- `push` mode: commit to default branch.
- `local` mode: stop after writing files and print the folder.

`--describe`: propose a one-line description and 3-6 topics per repo (lowercase, from stack and purpose). Show them, apply on yes with `gh repo edit <repo> --description "..." --add-topic ...`. Only fill empty descriptions unless user says overwrite.

`--license <id>`: if no LICENSE file, add one from the GitHub license text (`gh api licenses/<id>`), with the owner's name and current year. Same PR as the README. Never add or change a license on a repo that has one. Ask the user to confirm the license choice first: it is a legal decision.

Commit message: `docs: add README`. Follow the user's attribution rules for commits.

## Step 4b: Pin plan (`--pin-plan`)

Rank repos by: has a real README, recent activity, substance (size and structure), polish, variety of stack. Recommend 6, one line of reasoning each, and note which need work first. GitHub has no API for pins, so the user pins manually.

## Step 4c: Portfolio site (`--portfolio-site`)

Follow [references/portfolio-site.md](references/portfolio-site.md). Builds a static GitHub Pages site from the analyzed repos with `scripts/build-portfolio.py`. Output goes to a `<user>.github.io` repo (or `docs/` of the profile repo) via the same mode (pr/push/local). Default `local` preview first.

## Step 5: Profile README (only with `--profile-readme`)

Build `<user>/<user>/README.md` from [references/profile-readme.md](references/profile-readme.md): short intro, pinned-project highlights with screenshots, stack list. Use the same pr/push/local mode. Suggest which 6 repos to pin (GitHub pins cannot be set via API; tell user to pin manually).

## Step 6: Report

Print a table: repo | README | PR link | suggested topics. List anything skipped and why. End with next-step suggestions from [references/ideas.md](references/ideas.md) only if the user asks.

## Done criteria

Every chosen repo has a README written (or consciously skipped), nothing pushed without confirmation.
