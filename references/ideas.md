# Feature ideas (not yet built)

Shipped: audit-only, security, describe/topics, license, screenshots, pin-plan, portfolio-site, config. See SKILL.md.

- `--audit-only`: score every repo, output a ranked fix list, change nothing.
- `--templates <dir>`: user-supplied README templates and house style.
- `--lang <code>`: README in another language, or bilingual.
- `--architecture`: add a mermaid architecture diagram from detected structure.
- `--screenshots`: boot the app, capture real screenshots with a headless browser, embed them.
- `--demo-gif`: record a short run-through GIF.
- `--social`: draft LinkedIn / X posts per project.
- `--topics` and `--describe`: auto-apply topics and repo descriptions (with confirm).
- `--license <id>`: add a LICENSE file where missing.
- `--community`: add CONTRIBUTING.md, CODE_OF_CONDUCT.md, issue and PR templates.
- `--ci`: add a basic GitHub Actions workflow per detected stack.
- `--security`: scan for committed secrets, outdated deps, missing .gitignore.
- `--changelog`: generate CHANGELOG from commit history.
- `--pin-plan`: recommend the best 6 repos to pin, with reasoning.
- `--resume`: export a project-highlights section for a resume / LinkedIn.
- `--portfolio-site`: generate a GitHub Pages portfolio from analyzed repos.
- `--recruiter-view`: score the profile as a recruiter would, with top 5 fixes.
- `--schedule`: re-run monthly, only touch repos with new activity.
- `--config glowup.yml`: persist defaults (mode, excludes, per-repo overrides).
