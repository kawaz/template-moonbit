# コミット・プッシュ前チェック

コミットやプッシュの前に以下を実行:

```bash
just ci
```

（moon fmt --check + moon check --deny-warn + moon test --target all）
