# Project

<!-- プロジェクトの概要をここに記述 -->

## Commands

```bash
just fmt        # フォーマット
just check      # moon check --deny-warn
just test       # テスト
just test-all   # 全ターゲットテスト（native, js, wasm-gc, wasm）
just ci         # CI 相当（fmt-check + check + test-all）
just build      # リリースビルド
just push       # fmt-check + check + test してから push
just coverage   # カバレッジ
just release    # リリース（version bump + push + tag）
```

## Structure

```
src/                # ソースコード（moon.mod.json の "source": "src"）
docs/               # ドキュメント
  decisions/        # 設計判断記録（DR-*）
.github/workflows/  # CI/CD
  ci.yml            # lint → test（4ターゲット matrix）
  publish.yml       # mooncakes.io publish（tag トリガー）
```

## Guidelines

- コミットメッセージ: Conventional Commits (feat:, fix:, chore:, docs:, refactor:)
- テストファースト開発
- テストファイル命名:
  - `*_test.mbt` — ブラックボックステスト（公開 API）
  - `*_wbtest.mbt` — ホワイトボックステスト（内部 API）
  - `*_wbbench.mbt` — ベンチマーク
- スナップショットテスト: `inspect(val, content="...")`
- `just ci` を通してから push
- push は `just push` を使う（直接 push は hook でブロック）
- リリースは `just release` で自動化
