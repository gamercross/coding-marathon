# my-dev-process — 세션 안내

이 저장소는 "문제 저장 → 문제 분석 → 패턴 분석 → 패턴 구현 → 구현 → 서비스 →
유지보수"의 7단계 개인 개발 워크플로우입니다. 원문제: 새 프로젝트를 시작할
때마다 즉흥적으로 접근해서, 배운 게 다음 프로젝트에 재사용되지 않는다.

이 파일은 **라우터**입니다 — 방법론·절차 자체를 담지 않고, 지금 하려는
작업에 맞는 파일을 어디서 읽어야 하는지만 알려줍니다(전체 맥락을 매번 다
불러오지 않기 위함). 200줄 이내로 유지합니다.

## 아무 작업이든 시작하기 전에

- 새 문제/프로젝트를 시작하면 → [`docs/00-overview/scope-tiers.md`](docs/00-overview/scope-tiers.md)로
  등급(Full/Xpress/Lite/즉시처리)부터 정한다.
- 단계를 넘어갈 때마다 → [`docs/00-overview/gates.md`](docs/00-overview/gates.md)의
  DoR/DoD로 확인한다.

## 작업 경로 → 먼저 읽을 규칙 파일

| 지금 하려는 작업 | 먼저 읽을 파일 |
|---|---|
| `docs/**` 문서를 새로 쓰거나 고침 | [`.claude/rules/docs-editing.md`](.claude/rules/docs-editing.md) |
| `implementations/**` 코드를 새로 쓰거나 고침 | [`.claude/rules/implementations.md`](.claude/rules/implementations.md) |
| git 명령(커밋, 브랜치, 푸시 등) | [`.claude/rules/git-workflow.md`](.claude/rules/git-workflow.md) |
| `docs/01-problem-save/sessions/**`에 새 세션 저장, 또는 `dev-workflow` 명령 1 | [`.claude/rules/problem-save-gate.md`](.claude/rules/problem-save-gate.md) |
| `CLAUDE.md`/`.claude/rules/**`/`.claude/hooks/**`/`.claude/agents/**`/`dev-workflow` 스킬 자체를 고침 | [`.claude/rules/consistency.md`](.claude/rules/consistency.md) |
| 새 외부 스킬/플러그인/MCP를 설치·평가(`dev-workflow` 명령 4) | [`.claude/rules/external-integration.md`](.claude/rules/external-integration.md) |

**규칙 파일은 필요할 때만 읽으세요** — 이 CLAUDE.md에는 내용을 옮겨 적지
않습니다. 매칭되는 규칙이 없으면 그냥 진행하되, 위험한 git 명령이나 테스트
없는 커밋은 훅(`.claude/hooks/`)이 기계적으로 한 번 더 막습니다.

## `dev-workflow` 스킬 — Skill 절차 분리

`.claude/skills/dev-workflow/SKILL.md`는 트리거·개요만 담고, 실제 실행
절차(명령 1·2·3의 세부 단계)는 같은 폴더의 `PROCEDURE.md`에 있습니다.
명령을 실제로 수행하는 시점에만 `PROCEDURE.md`를 읽으세요 — 스킬이
트리거됐다는 사실만으로 절차 전체를 미리 읽지 않습니다.

이렇게 나눈 이유: SKILL.md는 트리거 판단마다 로드되는 반면 PROCEDURE.md는
명령을 실제로 실행할 때만 필요합니다. 절차가 늘어날수록(지금 107줄 → 계속
증가) 트리거 판단 자체가 무거워지는 걸 막기 위해 분리했습니다.

## 검증은 직접 하지 말고 위임

전체 테스트나 문서 링크 무결성 같은 **출력이 긴 검증 작업**은 직접 돌리지
말고 [`.claude/agents/verify.md`](.claude/agents/verify.md) 서브에이전트에
위임하세요 — 격리된 컨텍스트에서 실행하고, 압축된 요약만 돌아옵니다. 다음
경우에 특히 그렇습니다:

- 커밋하기 전
- 7단계(회고 반영) 완료 전
- 여러 파일을 한 번에 고친 뒤 전체가 여전히 통과하는지 확인할 때

## 훅 — 사람 판단에만 맡기지 않는 것

`.claude/hooks/`에 다음이 기계적으로 강제됩니다(모델이 잊어도 막힘):

| 훅 | 막는 것 |
|---|---|
| `block-dangerous-git.sh` | `git push --force`, `git reset --hard`, `git clean -f` |
| `require-tests-before-commit.sh` | 테스트가 실패한 상태에서 `git commit` |
| `check-links.sh` | `*.md` 편집 후 깨진 상대 링크가 남은 상태로 넘어가는 것 |

훅이 차단하면 스택트레이스가 아니라 이유가 stderr로 온다 — 그 이유를 고친
뒤 재시도한다. 훅에 걸리는 걸 피하려고 우회하지 않는다.

## 브랜치

- `main` — 실제 작업 이력 전체(개인 기록 포함), private.
- `template` — 개인 기록을 뺀 배포용 스냅샷. **main으로 머지하지 않는다** —
  실제 배포처는 별도 저장소 `gamercross/my-dev-process-template`(public).
- `team` — 팀 프로젝트(코딩마라톤 등) 협업용 워크스페이스. 이 CLAUDE.md와
  `.claude/` 구조 자체가 이 브랜치의 작업 대상입니다.

## 이 저장소 전체를 처음 보는 경우

- 전체 그림·진행상황: [`docs/00-overview/README.md`](docs/00-overview/README.md)
- 다른 사람이 이 시스템을 처음 쓰는 법: [`GETTING_STARTED.md`](GETTING_STARTED.md)
- 지금까지 실제로 진행한 모든 항목: [`docs/01-problem-save/sessions/README.md`](docs/01-problem-save/sessions/README.md)
- 왜 지금 이 모양이 됐는지(시행착오 기록): [`docs/00-overview/worklog.md`](docs/00-overview/worklog.md)
