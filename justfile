# MoonBit Project

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

# CI 相当のチェック
ci: fmt-check check test-all
