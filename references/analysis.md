# Repo analysis

## Health score (0-10, one point each)
1. README exists
2. README over 400 chars and has run instructions
3. Description set
4. Topics set (3+)
5. License present
6. Pushed in last 12 months
7. Has tests or CI
8. Has screenshot or demo asset
9. Homepage/demo URL set
10. Has .gitignore and no committed secrets/node_modules

Low score + recent activity + real code = best candidates for a glow-up.

## What to extract per repo
- Purpose: from package metadata, existing README, entry files, route/page names.
- Stack: manifests (`package.json`, `pyproject.toml`, `pom.xml`, `go.mod`, `Cargo.toml`, `build.gradle`, `Dockerfile`).
- Run: scripts section, `Makefile` targets, Docker compose.
- Config: `.env.example`, config files. List variable names, never values.
- Structure: top 2 directory levels, one line each.
- Assets: images in `public/`, `docs/`, `assets/` usable as screenshots.
- License: file or manifest field.
- Skip: `node_modules`, `.git`, build output, lockfiles, binaries.

## Output (compact JSON per repo)
`{name, pitch, type, stack[], install, run, test, env[], structure[], assets[], license, unknowns[]}`

## Secrets
If a secret-looking value is found in the repo, do not copy it anywhere. Flag it to the user in the report.
