#!/usr/bin/env bash
# PreToolUse hook on Bash. 위험한 git 명령을 기계적으로 차단한다 —
# .claude/rules/git-workflow.md의 "절대 하지 않는 것"을 모델 판단에만
# 맡기지 않고 강제한다.
cmd=$(cat | jq -r '.tool_input.command // empty')

if echo "$cmd" | grep -qE '(^|[;&|]|\s)git\s+push\s+(--force|-f)(\s|$)'; then
  echo "🚫 차단됨: git push --force는 사용자의 명시적 확인 없이 실행할 수 없습니다." >&2
  echo "명령: $cmd" >&2
  exit 2
fi

if echo "$cmd" | grep -qE '(^|[;&|]|\s)git\s+reset\s+--hard(\s|$)'; then
  echo "🚫 차단됨: git reset --hard는 사용자의 명시적 확인 없이 실행할 수 없습니다." >&2
  echo "명령: $cmd" >&2
  exit 2
fi

if echo "$cmd" | grep -qE '(^|[;&|]|\s)git\s+clean\s+.*-f'; then
  echo "🚫 차단됨: git clean -f는 사용자의 명시적 확인 없이 실행할 수 없습니다." >&2
  echo "명령: $cmd" >&2
  exit 2
fi

exit 0
