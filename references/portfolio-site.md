# Portfolio site

Static one-page site, no build tooling, hosted on GitHub Pages.

## Steps
1. Write `portfolio.json` from the analyzed repos (schema below). Use only facts from analysis; ask the user for name, tagline, links.
2. Include only repos the user selected. Order by pin-plan if available.
3. Run `python3 -I <skill-dir>/scripts/build-portfolio.py portfolio.json out/` . It writes `out/index.html` (inlined CSS, light and dark, mobile friendly).
4. Preview locally: `python3 -m http.server -d out 8080`. Show the user.
5. Publish after confirmation, per `--mode`:
   - Preferred: repo `<user>/<user>.github.io`. Create it only on confirmation (`gh repo create`). Pages serves it automatically.
   - Alternative: `docs/` folder in an existing repo, then enable Pages (`gh api -X POST repos/<owner>/<repo>/pages -f "source[branch]=main" -f "source[path]=/docs"`), confirm first.
6. Report the live URL (`https://<user>.github.io`).

## portfolio.json
```json
{
  "name": "Your Name",
  "tagline": "One line about what you build",
  "about": "Two or three sentences.",
  "links": {"GitHub": "https://github.com/you", "LinkedIn": "https://..."},
  "projects": [
    {"name": "Repo", "pitch": "One line", "stack": ["React", "TypeScript"],
     "repo": "https://github.com/you/repo", "demo": "", "image": "", "video": ""}
  ]
}
```
`demo`, `image`, `video` are optional. Images must be real captures or poster frames. Page text is HTML-escaped by the builder.
