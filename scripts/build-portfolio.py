#!/usr/bin/env python3
"""Build a static portfolio page. Usage: build-portfolio.py portfolio.json outdir"""
import html, json, os, shutil, sys

def esc(v): return html.escape(str(v or ""), quote=True)
def url(v):
    v = str(v or "")
    return esc(v) if v.startswith(("https://", "http://")) else ""

def main():
    if len(sys.argv) != 3:
        sys.exit("usage: build-portfolio.py portfolio.json outdir")
    src, out = sys.argv[1], sys.argv[2]
    data = json.load(open(src))
    tpl_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "assets")
    tpl = open(os.path.join(tpl_dir, "portfolio-template.html")).read()
    os.makedirs(out, exist_ok=True)

    links = "".join(f'<a href="{url(u)}">{esc(k)}</a>' for k, u in (data.get("links") or {}).items() if url(u))
    cards = []
    for p in data.get("projects", []):
        img = ""
        if p.get("image"):
            ip = str(p["image"])
            if os.path.isfile(ip):  # local file: copy next to index.html
                name = os.path.basename(ip)
                shutil.copy(ip, os.path.join(out, name)); ip = name
            elif not ip.startswith("https://"):
                ip = ""
            if ip: img = f'<img src="{esc(ip)}" alt="{esc(p.get("name"))} screenshot" loading="lazy">'
        stack = "".join(f"<li>{esc(s)}</li>" for s in p.get("stack", []))
        btns = ""
        if url(p.get("repo")): btns += f'<a href="{url(p["repo"])}">Code</a>'
        if url(p.get("demo")): btns += f'<a href="{url(p["demo"])}">Live demo</a>'
        if url(p.get("video")): btns += f'<a href="{url(p["video"])}">Video</a>'
        cards.append(f'<article class="card">{img}<h3>{esc(p.get("name"))}</h3><p>{esc(p.get("pitch"))}</p><ul class="stack">{stack}</ul><div class="btns">{btns}</div></article>')

    page = (tpl.replace("{{NAME}}", esc(data.get("name")))
               .replace("{{TAGLINE}}", esc(data.get("tagline")))
               .replace("{{ABOUT}}", esc(data.get("about")))
               .replace("{{LINKS}}", links)
               .replace("{{PROJECTS}}", "\n".join(cards)))
    open(os.path.join(out, "index.html"), "w").write(page)
    print(os.path.join(out, "index.html"))

main()
