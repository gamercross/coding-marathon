# `.claude/` 구조 자체를 고칠 때의 정합성 규칙

`CLAUDE.md`, `.claude/rules/*.md`, `.claude/hooks/*.sh`, `.claude/agents/*.md`,
`.claude/skills/dev-workflow/{SKILL,PROCEDURE}.md` 중 **하나라도** 고칠 때만
읽으세요. 이 파일들은 서로를 참조하는 "기준 계층"이라, 하나를 고치면 그걸
참조하던 다른 파일도 같이 낡을 수 있습니다.

`.claude/rules/docs-editing.md`의 규칙 3번(상태 문구 훑기)이 `docs/**`
일반 문서에 대한 **수동 습관**이라면, 이 파일은 그중에서도 **`.claude/`
구조 자체**를 위한 **명시적 참조 지도**입니다 — 어디를 훑어야 하는지 매번
추측하지 않도록 목록으로 고정해둡니다.

## 기준 파일 → 참조하는 파일 지도

고치려는 파일이 아래 왼쪽 열에 있으면, 오른쪽 열의 파일들도 내용이 여전히
맞는지 확인한다.

| 기준 파일(고치는 대상) | 이걸 참조하는 파일(같이 확인) |
|---|---|
| `CLAUDE.md` | `.claude/skills/dev-workflow/SKILL.md` (라우터 링크) |
| `.claude/rules/git-workflow.md` | `CLAUDE.md`(라우팅 표), `.claude/skills/dev-workflow/PROCEDURE.md`(명령 3의 커밋 단계) |
| `.claude/rules/docs-editing.md` | `CLAUDE.md`(라우팅 표), `.claude/skills/dev-workflow/PROCEDURE.md`(명령 3의 링크 체크 언급) |
| `.claude/rules/implementations.md` | `CLAUDE.md`(라우팅 표) |
| `.claude/rules/problem-save-gate.md` | `CLAUDE.md`(라우팅 표), `.claude/skills/dev-workflow/PROCEDURE.md`(명령 1의 PRD 게이트 단계) |
| `.claude/agents/verify.md` | `CLAUDE.md`("검증은 직접 하지 말고 위임"), `.claude/rules/implementations.md`, `.claude/skills/dev-workflow/{SKILL,PROCEDURE}.md` |
| `.claude/hooks/*.sh` | `CLAUDE.md`(훅 표), `.claude/settings.json`(등록 여부) |
| `.claude/skills/dev-workflow/SKILL.md` | `.claude/skills/dev-workflow/PROCEDURE.md`(서로 참조), `CLAUDE.md` |
| `.claude/skills/dev-workflow/PROCEDURE.md` | `.claude/skills/dev-workflow/SKILL.md`(서로 참조) |
| `.claude/rules/external-integration.md` | `CLAUDE.md`(라우팅 표), `.claude/skills/dev-workflow/{SKILL,PROCEDURE}.md`(명령 4), `docs/catalog/external-tools.md`(판정 기록 대상) |

**새 기준 파일을 추가하면(새 rules 파일, 새 hook, 새 agent 등) 이 표에도 행을
하나 추가한다.** 표 자체가 낡으면 이 규칙 전체가 무력화된다.

## 반드시 지킬 것

1. 위 표에서 자신의 행을 찾아, 오른쪽 열의 파일들을 실제로 열어서 여전히
   맞는 설명인지 확인한다 — 파일명이 바뀌었거나, 절차 번호가 바뀌었거나,
   더 이상 존재하지 않는 개념을 가리키면 그 자리에서 같이 고친다.
2. 확실하지 않으면 아래처럼 실제로 grep해서 놓친 참조가 있는지 확인한다
   (표는 알려진 참조만 담고 있고, 표에 없는 참조가 생겼을 수 있다):

   ```bash
   # <파일명>을 언급하는 모든 .md 파일을 찾는다 (표에 없는 참조가 있는지 확인)
   grep -rl "<파일명>" --include="*.md" .
   ```

3. `.claude/rules/docs-editing.md`의 링크 체크(깨진 상대 링크 0건)도 그대로
   적용된다 — 정합성 확인과 링크 체크는 별개다. 내용이 맞아도 링크가 깨질
   수 있고, 링크가 살아있어도 내용이 낡을 수 있다.

## 이 규칙이 하지 않는 것

- 자동 강제하지 않는다 — `check-links.sh`처럼 훅으로 기계적으로 막는 단계가
  아니라, 아직은 "표를 보고 사람이 확인하는" 단계다. 이 표 기반 확인이
  반복적으로 빠지는 게 실제로 드러나면, 표의 왼쪽 열을 grep 패턴으로 바꿔
  `.claude/hooks/`에 새 훅으로 승격하는 걸 다음 단계로 고려한다.
