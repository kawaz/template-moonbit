# Project

<!-- プロジェクトの概要をここに記述 -->

## Commands

```bash
just fmt        # フォーマット
just check      # moon check --deny-warn
just test       # テスト
just test-all   # 全ターゲットテスト（native, js, wasm-gc）
just ci         # CI 相当（fmt-check + check + test-all）
just build      # リリースビルド
just coverage   # カバレッジ
```

## Structure

```
src/                # ソースコード（moon.mod.json の "source": "src"）
docs/               # ドキュメント
.github/workflows/  # CI/CD
```

## Guidelines

- コミットメッセージ: Conventional Commits (feat:, fix:, chore:, docs:, refactor:)
- テストファースト開発
- テストファイル命名:
  - `*_test.mbt` — ブラックボックステスト（公開 API）
  - `*_wbtest.mbt` — ホワイトボックステスト（内部 API）
  - `*_wbbench.mbt` — ベンチマーク
- スナップショットテスト: `inspect!(val, content="...")`
- `moon check --deny-warn` を通すこと
