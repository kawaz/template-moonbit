# MoonBit Project

# デフォルト: レシピ一覧
default:
    @just --list

# フォーマット
fmt:
    moon fmt

# フォーマットチェック
fmt-check:
    moon fmt --check

# チェック（lint + 型チェック）
check:
    moon check --deny-warn

# テスト
test:
    moon test

# 全ターゲットテスト
test-all:
    moon test --target all

# スナップショット更新
test-update:
    moon test --update

# カバレッジ
coverage:
    moon test --enable-coverage
    moon coverage analyze -- -f summary

# ビルド（リリース）
build:
    moon build --release

# クリーン
clean:
    moon clean

# ワーキングコピーがクリーン（empty）であることを確認
ensure-clean:
    test "$(jj log -r @ --no-graph -T 'empty')" = "true"

# push (check + test を通してから push)
push: fmt-check check test
    jj git push

# CI 相当のチェック
ci: fmt-check check test-all

# リリース (bump: major, minor, patch)
release bump="patch": ensure-clean ci build
    #!/usr/bin/env bash
    set -euo pipefail

    # Version bump
    current=$(jq -r '.version' moon.mod.json)
    IFS='.' read -r major minor patchv <<< "$current"
    case "{{bump}}" in
        major) major=$((major + 1)); minor=0; patchv=0 ;;
        minor) minor=$((minor + 1)); patchv=0 ;;
        patch) patchv=$((patchv + 1)) ;;
        *) echo "Error: Invalid bump type '{{bump}}'" >&2; exit 1 ;;
    esac
    new_version="${major}.${minor}.${patchv}"
    jq --arg v "$new_version" '.version = $v' moon.mod.json > moon.mod.json.tmp && mv moon.mod.json.tmp moon.mod.json
    echo "Version: ${current} -> ${new_version}"

    # Commit and push
    jj describe -m "Release v${new_version}"
    jj new
    jj bookmark set main -r @-
    just push

    # Tag and push tag for publish workflow
    jj tag set "v${new_version}"
    git push origin "v${new_version}"
