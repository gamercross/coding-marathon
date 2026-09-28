# dev-workflow 실행 절차

`SKILL.md`가 이 스킬을 트리거했고, 실제로 명령 1/2/3 중 하나를 실행하는
시점에만 이 파일을 읽으세요. 방법론 자체(왜 이렇게 하는지)는 여기 없습니다 —
각 `docs/0X-*/README.md`를 참고하세요.

## 명령 1: 새 문제/프로젝트 저장 (1단계)

1. **먼저 규모를 정한다** ([`docs/00-overview/scope-tiers.md`](../../../docs/00-overview/scope-tiers.md)):
   전체가 2~5분 안에 끝나면 **즉시처리**로 아무 단계도 안 밟고 끝낸다. 그 외엔
   Xpress/Lite/Full 중 하나를 정하고 이후 단계에 반영한다. 이 결정 트리 중 "표준
   패턴으로 바로 풀리는가?" 질문에 답하려면 여기서 먼저
   `docs/catalog/patterns.md`를 키워드로 훑어본다 (명령 2와 같은 방식) — 별도
   단계가 아니라 이 규모 판단의 입력값이다.
2. `docs/01-problem-save/`에서 위 규칙으로 트랙 템플릿 목록을 나열한다. 문제
   설명 자체가 트랙을 명백히 가리키면(예: "LeetCode #N" 같은 알고리즘 문제 번호,
   또는 "~앱/서비스를 만들고 싶다" 같은 프로젝트 서술) 그 트랙으로 자동 선택하고
   사용자에게는 "○○ 트랙으로 저장할게요"라고 통보만 한다. 트랙이 무엇인지
   설명만으로 애매하면 그때 사용자에게 고르게 한다. 템플릿이 1개뿐이면 항상 자동 선택.
3. 템플릿 필드를 **사용자가 준 설명을 그대로 옮겨 적지 말고, 인터뷰 기법으로
   되물어서 채운다** — [`docs/01-problem-save/README.md`](../../../docs/01-problem-save/README.md)의
   "필드는 어떻게 채우는가" 절(Gause & Weinberg의 컨텍스트-프리 질문) 참고.
   질문은 한 번에 다 던지지 않고 **1~2개씩, 답변을 보고 다음 질문을
   좁혀간다** — 진짜 대화처럼. 답변에 "빠르다/편하다" 같은 정성적 표현이
   나오면 그 자리에서 바로 숫자로 되묻는다. 깊이는 등급에 비례한다(Full=4개
   범주 전부, Xpress=성공기준 위주, Lite/즉시처리=생략 — 같은 문서 참고).
   필수 필드가 비어 있으면 다음 단계로 넘어가지 않는다(1단계 IEEE 830 규칙).
   질문이 끝나면 채운 내용을 "이렇게 이해했는데 맞나요?"로 한 번 더 확인받은
   뒤에만 확정한다. **Full 등급 + 프로젝트 트랙이면**, 여기서
   [`.claude/rules/problem-save-gate.md`](../../rules/problem-save-gate.md)의
   PRD 게이트 규칙을 따른다 — 확장 여부를 반드시 물어보고 기록한 뒤에만
   진행한다.
4. 완성된 내용을 아래 규칙으로 저장한다:

   ```
   docs/01-problem-save/sessions/<트랙파일명(확장자 제외)>/<YYYY-MM-DD>-<슬러그>.md
   ```

   예: `docs/01-problem-save/sessions/algorithm-track/2026-09-20-two-sum.md`

5. 저장한 세션 파일 맨 아래에
   [`docs/00-overview/gates.md`](../../../docs/00-overview/gates.md)의 "새 문제/
   프로젝트용 게이트 로그 템플릿" 블록을 붙여서 시작한다 (등급 줄부터 채우고 1→2
   게이트부터 진행). 이게 없으면 이 문제가 어느 게이트까지 통과했는지 남길 곳이 없다.
6. 저장 후 다음을 확인한다: **알고리즘 트랙의 단순 문제는 보통 2단계를 생략하고 바로
   [3단계 패턴 분석](../../../docs/03-pattern-analysis/README.md)으로 간다** — 2단계의
   5단계 파이프라인(BABOK/EARS/Planguage/Kano/RTM)은 무거운 프로젝트 트랙용이다
   ([`docs/02-problem-analysis/README.md`](../../../docs/02-problem-analysis/README.md)의
   "적용 범위" 참고). 프로젝트 트랙이거나 문제가 복잡하면 [2단계](../../../docs/02-problem-analysis/README.md)로.
7. [`docs/01-problem-save/sessions/README.md`](../../../docs/01-problem-save/sessions/README.md)의
   "트래커" 표에 새 행을 하나 추가한다 (문제/프로젝트명, 트랙, 등급, 패턴은 아직
   미정이면 "-", 게이트는 "1→2"). 이 표를 그때그때 갱신하지 않으면 나중에 git log를
   전부 뒤져야 전체 목록을 알 수 있다 — 그게 이 표를 만든 이유다.

## 명령 2: 패턴 검색 (3단계)

1. 사용자가 준 키워드/태그로 `docs/catalog/patterns.md`를 검색한다 (grep 방식).
2. 일치하는 항목이 있으면 각 항목의 "언제 쓰는가"/"트레이드오프"를 요약해 보여준다.
3. 없으면 표준 카탈로그로 안내한다 — 알고리즘 트랙은
   `docs/03-pattern-analysis/01-algorithm-paradigms.md`(설계 패러다임 + 구현 기법 패턴
   두 계층 모두 확인), 프로젝트 트랙은
   `docs/03-pattern-analysis/02-architecture-styles.md`.

## 명령 3: 회고를 카탈로그/체크리스트에 반영 (7단계)

1. `docs/07-maintenance/README.md`의 회고 템플릿으로 사용자와 함께 채운다 —
   "어려웠던 점"은 **5 Whys**로 근본원인까지 파고든다 (표면 증상에서 멈추지 않는다).
2. "새로 배운 패턴"이 나오면 `docs/catalog/patterns.md`에 기존 Volere 카드 형식 그대로
   추가한다.
3. "놓쳤던 체크리스트 항목"이 나오면 (5 Whys의 근본원인을 반영해서)
   `docs/catalog/checklist.md`에 추가한다.
4. [`docs/01-problem-save/sessions/README.md`](../../../docs/01-problem-save/sessions/README.md)
   트래커 표에서 이 항목의 행을 "게이트: 1→7 완주"로, "사용한 패턴"/"테스트" 열을
   최종값으로 갱신한다.
5. [`docs/00-overview/README.md`](../../../docs/00-overview/README.md)의 진행상황
   (Progress Log) 표와 [`docs/00-overview/worklog.md`](../../../docs/00-overview/worklog.md)에
   오늘 날짜로 짧게 기록한다 (무엇을 했고 다음 세션이 알아야 할 게 뭔지).
6. 검증은 직접 돌리지 말고 `.claude/agents/verify.md` 서브에이전트에 위임해서
   요약만 받는다 (전체 테스트 + 링크 체크).
7. 변경 사항을 git commit한다 — 커밋 메시지에 어떤 프로젝트/문제에서 나온
   교훈인지 명시. 커밋 전 `.claude/rules/git-workflow.md`를 따른다.

## 명령 4: 외부 스킬/MCP 통합 분석

새 공식 스킬·플러그인·MCP 서버를 설치하거나 평가할 때 실행한다. 자세한
규칙은 [`.claude/rules/external-integration.md`](../../rules/external-integration.md)에
있고, 여기는 실행 순서만 담는다.

1. 이 도구가 어떤 경로를 건드리는지(자기 폴더 안쪽뿐인지, `.claude/**`나
   `CLAUDE.md`·`docs/**`까지인지) 확인한다 — **도구마다 다르게**, 일괄
   체크리스트로 넘기지 않는다.
2. 우리 `.claude/rules/**`·`hooks/**`·`agents/**`와 겹치거나 충돌하는 게
   있는지 확인한다.
3. 이 도구가 우리 기준 파일(`CLAUDE.md`, `.claude/rules/**`,
   `.claude/hooks/**`, `.claude/agents/**`)을 스스로 고쳤다면, 그대로 받지
   말고 `.claude/rules/consistency.md`의 기준 파일 지도로 검토 후 커밋
   여부를 사람이 정한다.
4. 채택/격리/제거 중 하나로 판정하고
   [`docs/catalog/external-tools.md`](../../../docs/catalog/external-tools.md)에
   기록한다. 채택이면 `CLAUDE.md` 라우팅 표와 `consistency.md`의 기준 파일
   지도에도 새 행을 추가한다.
5. 이번 항목에서 실제로 이 도구를 썼다면, 명령 3(회고 반영)에서 통합 시점의
   판정이 실사용 후에도 맞았는지 다시 확인하고, 다르면 `checklist.md`에
   반영한다.
