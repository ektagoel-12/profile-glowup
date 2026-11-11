# No gh CLI fallback

Auth: `Authorization: Bearer $GITHUB_TOKEN` (needs `repo` scope for PRs). Never echo the token.

| Task | Call |
|---|---|
| List own repos | `GET /user/repos?affiliation=owner&per_page=100` |
| List user repos | `GET /users/{user}/repos?per_page=100` |
| README | `GET /repos/{owner}/{repo}/readme` |
| Create PR | `POST /repos/{owner}/{repo}/pulls` `{title, head, base, body}` |
| Description/homepage | `PATCH /repos/{owner}/{repo}` |
| Topics | `PUT /repos/{owner}/{repo}/topics` `{"names":[...]}` |

Git push uses the user's existing git credentials (SSH or credential helper).
