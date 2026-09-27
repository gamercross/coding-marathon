# implementations/** 작업 규칙

`implementations/**` 아래 코드를 새로 쓰거나 고칠 때만 읽으세요.

## 반드시 지킬 것

1. **TDD Red-Green-Refactor** — 알고리즘 트랙은 "브루트포스로 먼저 정답 확인
   (Red 없어도 됨) → 최적화(Refactor 자리)"로 변형해서 적용한다
   (`docs/05-implementation/01-tdd-red-green-refactor.md`).
2. **벤치마크의 "최악 케이스"는 반드시 실행해서 확인한다.** 논리적으로
   최악처럼 보이는 입력이 실제로는 더 빨리 끝나는 경우가 있었다(Two Sum
   회고). 작은 크기 여러 개에서 추세(2배씩 늘렸을 때 몇 배씩 느는지)를 먼저
   확인한 뒤 제약조건 상한에서 측정한다.
3. **새 파일명 관례를 쓰는 트랙/프로젝트를 추가하면
   `implementations/run_all_tests.py`가 그 관례도 자동으로 찾는지 확인한다**
   — `test_*.py` 글롭으로 이미 일반화돼 있지만, 새 규칙을 또 만들면 다시
   깨질 수 있다.
4. **저장소 자신의 상태(테스트 스위트, 파일 트리, git 이력)를 다루는 도구를
   만들 때는 그 도구 자신이 discovery 대상이 되어 자기 참조·무한 재귀를
   일으킬 수 있는지 먼저 따진다** (진행상황 대시보드 생성기 사례,
   `docs/catalog/checklist.md`의 "자기 참조 도구 체크리스트" 참고). 의존성
   주입으로 실제 파일시스템/재귀 경로를 피하고, 테스트는 격리해서 짠다.
5. 코드를 고친 뒤에는 **전체 테스트를 한 번에 돌려서** 다른 항목이 안 깨졌는지
   확인한다:

   ```bash
   python3 implementations/run_all_tests.py
   ```

   출력이 길면 `verify` 서브에이전트에게 위임하고 요약만 받는다
   (`.claude/agents/verify.md`).

## 코드 위치 규칙

```
implementations/
  run_all_tests.py
  <트랙파일명>/<세션 슬러그>/
    solution.py       # 브루트포스 + 최적화 둘 다 남김
    test_solution.py  # 단위 테스트 + 경계값/차등 테스트
    benchmark.py       # 6단계 성능 실측, 선택
```
