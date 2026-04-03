#!/bin/bash
# Claude Code pre-tool hook: git push を全てブロックし just push へ誘導する

input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command // empty')

if ! echo "$command" | grep -qE '(^|&&|;|\|\|)\s*(git\s+push|jj\s+git\s+push)\b'; then
  exit 0
fi

echo "BLOCK: push は直接実行できません。just push を使ってください。" >&2
exit 2
