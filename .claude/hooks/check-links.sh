#!/usr/bin/env bash
# PostToolUse hook on Edit|Write, *.md만. 문서를 고친 직후 링크 무결성을
# 기계적으로 확인해서, 깨진 링크를 놓치고 넘어가는 걸 막는다
# (.claude/rules/docs-editing.md 참고).
python3 - <<'EOF'
import re, pathlib, sys

root = pathlib.Path(".")
broken = []
for md in root.rglob("*.md"):
    text = md.read_text(encoding="utf-8")
    for m in re.finditer(r'\[[^\]]*\]\(([^)]+)\)', text):
        link = m.group(1)
        if link.startswith("http") or link.startswith("#"):
            continue
        target = link.split("#")[0]
        if not target:
            continue
        p = (md.parent / target).resolve()
        if not p.exists():
            broken.append((str(md), link))

if broken:
    print("⚠️ 깨진 상대 링크가 있습니다:", file=sys.stderr)
    for path, link in broken:
        print(f"  {path}: {link}", file=sys.stderr)
    sys.exit(2)
EOF
