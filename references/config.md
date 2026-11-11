# glowup.yml

Optional file in the working directory. Flags override it.

```yaml
mode: pr                 # pr | push | local
exclude: [dotfiles, Extra, 20803007]   # repos to never touch
security: scan           # off | scan
license: MIT             # SPDX id, omit to skip
describe: true
screenshots: false
portfolio_site: false
repos:                   # per-repo overrides
  Between-Us:
    demo_url: https://example.com
```

`exclude` always wins over `--repos all`.
