# プラグイン機能対応表

この文書では、各機能を実現するためのプラグインと設定方法を説明します。
REQUIREMENTS.mdで必要な機能を決めた後、ここを参照して実装します。

---

## 基本設定（プラグイン不要）

これらは `lua/base.lua` に書く設定です。

### 表示設定
```lua
vim.o.number = true              -- 行番号表示
vim.o.cursorline = true          -- カーソル行ハイライト
vim.o.list = true                -- タブ・スペース可視化
vim.o.termguicolors = true       -- 24bitカラー有効化
```

### 編集設定
```lua
vim.o.clipboard = "unnamedplus"  -- システムクリップボード連携
vim.o.smartindent = true         -- 自動インデント
vim.o.expandtab = true           -- タブをスペースに
vim.o.tabstop = 2                -- タブ幅
vim.o.shiftwidth = 2             -- インデント幅
vim.o.wrap = false               -- 行折り返ししない
```

### リーダーキー設定
```lua
vim.g.mapleader = ' '            -- Spaceキーをリーダーに
```

---

## プラグイン機能対応表

### カテゴリ1: 見た目・テーマ

| 機能 | プラグイン | 説明 | 難易度 |
|------|-----------|------|--------|
| カラースキーム | `folke/tokyonight.nvim` | 人気のダークテーマ | ⭐ |
| | `catppuccin/nvim` | パステル調テーマ | ⭐ |
| | `rebelot/kanagawa.nvim` | 和風テーマ | ⭐ |
| ステータスライン | `nvim-lualine/lualine.nvim` | 下部の情報バー | ⭐⭐ |
| アイコン | `nvim-tree/nvim-web-devicons` | ファイルアイコン表示 | ⭐ |

**最小構成:** カラースキームだけでOK

---

### カテゴリ2: ファイル管理

| 機能 | プラグイン | 説明 | 難易度 |
|------|-----------|------|--------|
| ファイルツリー | `nvim-tree/nvim-tree.lua` | 左側にファイル一覧 | ⭐⭐ |
| ファイル検索 | `nvim-telescope/telescope.nvim` | 曖昧検索・grep検索 | ⭐⭐⭐ |
| | `ibhagwan/fzf-lua` | より軽量な検索 | ⭐⭐ |

**最小構成:** Telescopeだけでファイル検索とgrep両方できる

**依存関係:**
- Telescope → `nvim-lua/plenary.nvim` が必要

---

### カテゴリ3: コード補完

| 機能 | プラグイン | 説明 | 難易度 |
|------|-----------|------|--------|
| 補完エンジン | `hrsh7th/nvim-cmp` | 補完のコア | ⭐⭐⭐ |
| LSP連携 | `hrsh7th/cmp-nvim-lsp` | 言語サーバーの補完 | ⭐⭐ |
| バッファ補完 | `hrsh7th/cmp-buffer` | 開いているファイルから | ⭐ |
| パス補完 | `hrsh7th/cmp-path` | ファイルパス補完 | ⭐ |

**最小構成:**
```
nvim-cmp (本体)
├─ cmp-nvim-lsp (LSPからの補完)
└─ cmp-buffer (バッファからの補完)
```

---

### カテゴリ4: LSP（言語サーバー）

| 機能 | プラグイン | 説明 | 難易度 |
|------|-----------|------|--------|
| LSP設定 | `neovim/nvim-lspconfig` | LSPの設定を簡単に | ⭐⭐⭐ |
| LSPインストーラ | `williamboman/mason.nvim` | LSPサーバーを自動インストール | ⭐⭐⭐ |
| Mason-LSP連携 | `williamboman/mason-lspconfig.nvim` | MasonとLSPconfigを繋ぐ | ⭐⭐ |

**重要:** LSPは言語ごとにサーバーのインストールが必要
- TypeScript → `typescript-language-server`
- Go → `gopls`
- Ruby → `ruby-lsp`
- Lua → `lua-language-server`

**最小構成:** `nvim-lspconfig` だけ（手動でLSPサーバーインストール）
**楽な構成:** Mason使って自動インストール

---

### カテゴリ5: シンタックスハイライト

| 機能 | プラグイン | 説明 | 難易度 |
|------|-----------|------|--------|
| 高度なハイライト | `nvim-treesitter/nvim-treesitter` | コード構造を理解して色付け | ⭐⭐⭐ |

**注意:** Neovim 0.11では組み込みTreesitterがあるので、プラグインは必須ではない

---

### カテゴリ6: フォーマッター

| 機能 | プラグイン | 説明 | 難易度 |
|------|-----------|------|--------|
| フォーマット | `stevearc/conform.nvim` | 各言語のフォーマッタを統一管理 | ⭐⭐⭐ |
| | `mhartington/formatter.nvim` | シンプルなフォーマッタ | ⭐⭐ |

**フォーマッタ例:**
- JavaScript/TypeScript → `prettier`
- Go → `gofmt`, `goimports`
- Lua → `stylua`
- Ruby → `rubocop`

---

### カテゴリ7: Git連携

| 機能 | プラグイン | 説明 | 難易度 |
|------|-----------|------|--------|
| Git表示 | `lewis6991/gitsigns.nvim` | 変更箇所を行番号脇に表示 | ⭐⭐ |
| Git操作 | `tpope/vim-fugitive` | エディタ内でGitコマンド | ⭐⭐⭐ |

---

### カテゴリ8: その他便利機能

| 機能 | プラグイン | 説明 | 難易度 |
|------|-----------|------|--------|
| コメント切り替え | `numToStr/Comment.nvim` | `gcc`でコメント化 | ⭐ |
| 括弧自動閉じ | `windwp/nvim-autopairs` | ()を自動で閉じる | ⭐ |
| インデント可視化 | `lukas-reineke/indent-blankline.nvim` | インデントラインを表示 | ⭐⭐ |

---

## 推奨構成レベル

### レベル1: 最小構成（初心者向け）
```
必要なもの:
- 基本設定のみ（base.lua）
- カラースキーム 1つ

所要時間: 10分
学習負担: 最小
```

### レベル2: 快適な編集（標準）
```
レベル1 +
- Telescope（ファイル検索）
- nvim-tree（ファイルツリー）
- Comment.nvim（コメント切り替え）

所要時間: 30分
学習負担: 低
```

### レベル3: コーディング支援（中級）
```
レベル2 +
- nvim-lspconfig（言語サーバー）
- nvim-cmp（補完）
- conform.nvim（フォーマット）

所要時間: 1〜2時間
学習負担: 中
前提知識: LSPの概念
```

### レベル4: フル装備（上級）
```
レベル3 +
- Mason（LSP自動管理）
- gitsigns（Git連携）
- その他便利プラグイン

所要時間: 2〜3時間
学習負担: 高
```

---

## プラグイン設定の基本形

### パターン1: シンプルなプラグイン
```lua
return {
  "プラグイン名/リポジトリ",
}
```

### パターン2: 設定が必要なプラグイン
```lua
return {
  "プラグイン名/リポジトリ",
  config = function()
    require('プラグイン名').setup({
      -- 設定内容
    })
  end
}
```

### パターン3: 依存関係があるプラグイン
```lua
return {
  "プラグイン名/リポジトリ",
  dependencies = {
    "依存プラグイン1",
    "依存プラグイン2",
  },
  config = function()
    require('プラグイン名').setup({})
  end
}
```

### パターン4: キーマップ付きプラグイン
```lua
return {
  "プラグイン名/リポジトリ",
  keys = {
    { "<leader>f", "<cmd>コマンド<cr>", desc = "説明" },
  },
}
```

---

## 次のアクション

1. **REQUIREMENTS.md を埋める**
   - 必要な機能にチェック
   - 優先順位を決める

2. **構成レベルを選ぶ**
   - レベル1から始めるのを推奨
   - 動いたら1つずつ追加

3. **段階的に構築**
   - 一度に全部入れない
   - 1つ追加 → 動作確認 → 理解 → 次へ

4. **この文書を参照**
   - 機能を追加したいとき
   - プラグインの選択肢を知りたいとき
   - 設定方法を確認したいとき
