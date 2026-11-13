# README rules

1. Pitch first: one sentence, what and for whom.
2. Show it: screenshot or GIF near the top if one exists.
3. Features: 3-6 bullets taken from real code.
4. Quick start: exact commands, verified against manifests.
5. Config: env var names with one-line meaning.
6. Structure: only if the repo has more than a few folders.
7. Tech stack: short list.
8. License line only if a license file exists.
9. No filler ("blazing fast", "robust"), no invented roadmap, no fake badges.
10. Keep under ~150 lines. Small project, short README.

Existing README: preserve author content, voice, links, credits. Restructure and fill gaps. Show diff.

If something is unknown (demo URL, motivation), leave a clearly marked `<!-- TODO -->` or ask the user once for all repos together.

## Conflicts between an old README and current code

| Kind of claim | Winner | Action |
|---|---|---|
| Commands, ports, env vars, stack, dependencies | Code and config | Rewrite to match. Note the change in the PR body. |
| Features | Code and tests | Remove or mark as planned if nothing in code backs it. List it in the PR body. |
| Purpose, motivation, story, credits, links | Old README | Keep as written by the author. |
| Ambiguous (half-built, renamed, deleted) | User | Ask. Until answered, keep the old text with a `<!-- TODO: verify -->` comment. |

Check git history before deleting a claim: it may have been removed on purpose, or the code may simply be behind the docs.
