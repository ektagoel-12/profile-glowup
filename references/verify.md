# Verify step

Checks README claims before any PR. Execution is optional and always the user's call.

## Ask first (once per run, before step 3)

Ask the user in chat:

> Should I run commands from the READMEs to verify them? Pick one:
> 1. **static** (default): no execution. Check that commands, scripts, files and env vars exist.
> 2. **install**: also run install, build and test commands in the clone.
> 3. **run**: also start the app briefly and check it responds.

Say plainly that levels 2 and 3 execute code from the repos. Recommend `static` for repos the user does not own or does not recognize. Flags: `--verify static|install|run` skips the question. Never assume consent from an earlier run.

## Checks

**static (always)**
- Every command in the README maps to a real script, Makefile target or file.
- Every linked file and image exists.
- Every env var named in the README appears in code or `.env.example`.
- Feature claims match code or tests. Flag claims with nothing behind them.
- Claims vs git history: features removed or renamed since the README text came from.

**install** (adds)
- Fresh shallow clone in a temp dir. Run the documented install, then build and test if documented. 5 minute timeout per command.
- No real secrets passed in. Use `.env.example` values only.
- Result per command: `verified`, `failed` (keep the error line), or `skipped` (needs keys, DB, device or emulator).

**run** (adds)
- Start the documented run command in the background, wait up to 60s for HTTP 200 or a log line, then stop it.
- Skip mobile apps, anything needing a paid key, DB or external service.

## On failure
Do not hide it. Either fix the README (for example `npm install --legacy-peer-deps`) and re-verify, or put the failure in the PR body and the report. Never claim a command works that was `skipped` or `failed`.

## Output
A table in the PR body and the final report: command | level | result. Static-only runs say "not executed".
