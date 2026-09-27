# git 작업 규칙

git 명령을 실행하기 전에 읽으세요. 위험한 명령 일부는 훅(`.claude/hooks/`)이
기계적으로도 막지만, 훅에 기대지 말고 아래를 먼저 따르세요.

## 세션 시작 체크리스트

- 세션을 시작하거나 작업 디렉터리가 바뀌었다는 신호가 있으면 `git status`가
  정상 응답하는지 먼저 확인한다. 실패하거나(`.git` 손상) 있어야 할 파일이
  없으면 **로컬을 고치려 하지 말고 원격(GitHub)에서 다시 클론해서 복구**한다
  — 이 스크래치 워크스페이스는 세션 사이에 재구성될 수 있는 환경이라 이런
  손상이 반복적으로 발생했다(`docs/catalog/checklist.md` 참고). 손상됐던
  로컬은 삭제하지 말고 `<repo>-broken-<날짜>`로 이름만 바꿔 보존한다.

## 브랜치 규칙

- `template` 브랜치는 `main`의 개인 기록을 의도적으로 지운 배포용 스냅샷이다
  — **`main`으로 머지하지 않는다.** 배포는 별도 저장소
  (`gamercross/my-dev-process-template`)로 이미 분리돼 있다.
- `team` 브랜치는 팀 프로젝트 협업용 워크스페이스다.
- 새 브랜치를 만들기 전 `git status`로 작업 트리가 깨끗한지 확인한다.

## 커밋 규칙

- 커밋 전에 `python3 implementations/run_all_tests.py`와 링크 체크(
  `.claude/rules/docs-editing.md` 참고)가 통과하는지 확인한다 — 훅이 테스트를
  강제로 먼저 돌리지만, 실패를 미리 알고 있는 게 낫다.
- 커밋 메시지는 어떤 프로젝트/문제에서 나온 변경인지 명시하고,
  `Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>`로 끝낸다.
- git author 이메일은 `103008711+gamercross@users.noreply.github.com`(로컬
  저장소 설정)을 쓴다 — 실제 Gmail 주소를 새 커밋에 노출하지 않는다.

## 절대 하지 않는 것

- `git push --force`(사용자가 명시적으로 요청하지 않는 한)
- `git reset --hard`, `git clean -f`(먼저 `git status`로 확인 없이)
- ADR이 `Status: Accepted`인데 본문을 고치는 것 — 새 ADR로 대체한다
