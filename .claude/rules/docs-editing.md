# docs/** 편집 규칙

이 파일은 `docs/**` 아래 무언가를 새로 쓰거나 고칠 때만 읽으세요.

## 반드시 지킬 것

1. **모든 상대 링크는 실제로 존재하는 파일을 가리켜야 한다.** 앵커(`#절-이름`)는
   추측하지 말 것 — GitHub의 슬러그 생성 규칙을 손으로 재현하다 여러 번 깨진
   전례가 있다. 앵커가 꼭 필요하면 실제로 렌더링해서 확인하거나, 파일 링크만
   쓴다.
2. **`docs/03-pattern-analysis/adr/*.md` 중 `Status: Accepted`인 파일은 본문을
   고치지 않는다.** 오탈자 수정만 허용. 결정이 바뀌면 새 ADR을 만들어
   `Superseded by ADR-NNNN`으로 상태만 바꾼다.
3. **여러 곳에 흩어진 "상태"/"개수" 문구(각 단계 README의 상태 배너, 루트
   README, 진행상황 표)를 하나 고쳤으면, 같은 유형의 문구가 다른 파일에도
   있는지 훑는다.** ("저장소 정합성 체크리스트", `docs/catalog/checklist.md`
   참고 — 이걸 안 지켜서 실제로 스테일 버그가 여러 번 났다.)
4. 편집이 끝나면 아래 링크 체크를 돌려서 0건인지 확인한다 (훅이 자동으로도
   한 번 더 확인하지만, 먼저 스스로 확인하는 습관을 들인다):

   ```bash
   python3 - <<'EOF'
   import re, pathlib
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
   print("BROKEN" if broken else "no broken links", broken)
   EOF
   ```

## 참고만 하면 되는 것

- 새 트랙 템플릿은 `docs/01-problem-save/`에 파일 하나만 추가 — 스킬 로직을
  바꿀 필요 없음(ADR-0001).
- 방법론 자체(왜 이렇게 하는지)는 각 `docs/0X-*/README.md`에 이미 있음 — 여기
  다시 옮겨 적지 않는다.
