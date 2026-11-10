#!/usr/bin/env python3
"""Structural checks for the skill library. Run: python3 scripts/check-skills.py

For every folder under skills/ and workflows/:
  - it has a SKILL.md whose frontmatter has a non-empty `name` and `description`;
  - `name` matches the folder name (that is what agents load it by);
  - skills/README.md (the index) lists its path.
Also: every path the index lists exists, and every relative Markdown link in a
SKILL.md, command.md or README points at a file that exists (links inside code
blocks are examples and are skipped).

Exits 1 with one line per problem, 0 when clean. No network, no dependencies.
"""

import re
import sys
from pathlib import Path

ROOT = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parents[1]
INDEX = ROOT / "skills" / "README.md"
LINK = re.compile(r"\[[^\]]*\]\(([^)\s]+)\)")
FENCE = re.compile(r"^\s*(```|~~~)")


def frontmatter(text):
    """The `key: value` pairs between the first two `---` lines."""
    lines = text.splitlines()
    if not lines or lines[0].strip() != "---":
        return None
    fields = {}
    for line in lines[1:]:
        if line.strip() == "---":
            return fields
        m = re.match(r"^([A-Za-z_-]+):\s*(.*)$", line)
        if m:
            fields[m.group(1)] = m.group(2).strip().strip("\"'")
    return None  # never closed


def links_outside_code(text):
    in_code = False
    for n, line in enumerate(text.splitlines(), 1):
        if FENCE.match(line):
            in_code = not in_code
            continue
        if in_code:
            continue
        for target in LINK.findall(re.sub(r"`[^`]*`", "", line)):
            yield n, target


def main():
    problems = []
    index = INDEX.read_text() if INDEX.is_file() else ""
    if not index:
        problems.append("skills/README.md (the index) is missing")

    for kind in ("skills", "workflows"):
        base = ROOT / kind
        if not base.is_dir():
            continue
        for d in sorted(p for p in base.iterdir() if p.is_dir() and not p.name.startswith(".")):
            rel = f"{kind}/{d.name}"
            skill = d / "SKILL.md"
            if not skill.is_file():
                problems.append(f"{rel}: no SKILL.md")
                continue
            fm = frontmatter(skill.read_text())
            if fm is None:
                problems.append(f"{rel}/SKILL.md: no frontmatter (--- block at the top)")
                continue
            for key in ("name", "description"):
                if not fm.get(key):
                    problems.append(f"{rel}/SKILL.md: frontmatter has no `{key}`")
            if fm.get("name") and fm["name"] != d.name:
                problems.append(f"{rel}/SKILL.md: name `{fm['name']}` does not match the folder `{d.name}`")
            if index and f"`{rel}/`" not in index:
                problems.append(f"{rel}: not listed in skills/README.md")

    for m in re.finditer(r"\*\*Path\*\*:\s*`([^`]+)`", index):
        if not (ROOT / m.group(1)).exists():
            problems.append(f"skills/README.md lists `{m.group(1)}`, which does not exist")

    docs = [ROOT / "README.md", INDEX] + sorted(ROOT.glob("skills/*/SKILL.md")) \
        + sorted(ROOT.glob("skills/*/command.md")) + sorted(ROOT.glob("workflows/*/SKILL.md")) \
        + sorted(ROOT.glob("workflows/*/command.md"))
    for doc in docs:
        if not doc.is_file():
            continue
        for n, target in links_outside_code(doc.read_text()):
            if re.match(r"^[a-z]+:", target) or target.startswith("#"):
                continue  # URL, mailto, anchor
            path = target.split("#", 1)[0]
            if path and not (doc.parent / path).exists():
                problems.append(f"{doc.relative_to(ROOT)}:{n}: broken link `{target}`")

    for p in problems:
        print(p)
    print(f"{len(problems)} problem(s)" if problems else "skills OK")
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
