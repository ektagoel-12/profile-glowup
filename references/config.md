# glowup.yml

Optional file in the working directory. Flags override it.

```yaml
mode: pr                 # pr | push | local
tone: default            # brag tone
exclude: [dotfiles, Extra, 20803007]   # repos to never touch
video_hosting: none      # release | none
security: scan           # off | scan
license: MIT             # SPDX id, omit to skip
describe: true
screenshots: false
portfolio_site: false
repos:                   # per-repo overrides
  Between-Us:
    video: true
    tone: polished
    demo_url: https://example.com
```

`exclude` always wins over `--repos all`.
