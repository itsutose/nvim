# Git関連のトラブルシューティング

## ❌ Gitマークが表示されない

### チェックリスト

#### 1. Gitリポジトリか確認
```bash
# ファイルと同じディレクトリで実行
cd ファイルがあるディレクトリ
git status
```

- **エラーが出る** → Gitリポジトリではない
  - 対処: `git init` で初期化するか、リポジトリ内に移動

- **正常に表示される** → Gitリポジトリ ✅

#### 2. ファイルがGit管理下にあるか確認
```bash
git ls-files ファイル名
```

- **何も表示されない** → 未追跡ファイル
  - gitsignsは表示されるが、`untracked` マーク（`┆`）
  - 対処: `git add` でトラッキング開始

- **ファイル名が表示される** → 管理下 ✅

#### 3. .gitignore で除外されていないか確認
```bash
git check-ignore -v ファイル名
```

- **何か表示される** → 除外されている
  - gitsignsは動作しない
  - 対処: .gitignore を修正

#### 4. gitsigns が読み込まれているか確認
```vim
" Neovim内で実行
:Gitsigns toggle_signs
```

- **エラーが出る** → gitsignsが読み込まれていない
  - 対処: `:Lazy sync` でプラグイン再インストール

- **マークが表示/非表示される** → 正常 ✅

---

## ❌ カレントディレクトリの罠

### 問題: 相対パスでファイルを開くとき

```bash
# ダメな例
cd /tmp
nvim myproject/src/main.rb  # 相対パス
→ /tmp/myproject/src/main.rb を開こうとする
→ ファイルが存在しないかもしれない
```

**対処法:**
```bash
# 方法1: 絶対パスで開く
nvim /Users/yamaguchi/myproject/src/main.rb

# 方法2: プロジェクトルートに移動してから開く
cd /Users/yamaguchi/myproject
nvim src/main.rb

# 方法3: cdコマンドとセットで
cd /Users/yamaguchi/myproject && nvim src/main.rb
```

---

## ❌ シンボリックリンクの問題

### 問題: リンク先とリンク元で挙動が異なる

```bash
# シンボリックリンクを作成
ln -s /Users/yamaguchi/myproject/src ~/shortcuts/src

# リンク経由で開く
nvim ~/shortcuts/src/main.rb
```

**挙動:**
- gitsignsはリンク先の実際のパス（`/Users/yamaguchi/myproject/src`）から.gitを探す
- 通常は問題ない ✅

---

## ✅ 推奨ワークフロー

### パターン1: プロジェクトルートから開く（推奨）

```bash
# 1. プロジェクトルートに移動
cd ~/myproject

# 2. Neovimでプロジェクトを開く
nvim .

# 3. Telescope でファイルを検索
# Neovim内で Space + p
```

**メリット:**
- カレントディレクトリがプロジェクトルート
- 相対パスが分かりやすい
- Telescopeの検索範囲が明確

### パターン2: 特定ファイルを直接開く

```bash
# 絶対パスで開く（場所を問わず安全）
nvim /Users/yamaguchi/myproject/src/main.rb

# またはプロジェクトルートに移動してから
cd ~/myproject
nvim src/main.rb
```

### パターン3: 複数プロジェクトを行き来する

```bash
# エイリアスを設定
alias project-a='cd ~/project-a && nvim .'
alias project-b='cd ~/project-b && nvim .'

# 使うとき
project-a  # プロジェクトAを開く
```

---

## 🔍 デバッグコマンド

### Neovim内で実行できるコマンド

```vim
" 現在のファイルのGitルートを確認
:!git rev-parse --show-toplevel

" Gitステータス確認
:!git status

" gitsignsの状態確認
:Gitsigns toggle_signs  " ON/OFF切り替え
:Gitsigns toggle_current_line_blame  " blame切り替え

" プラグインが読み込まれているか確認
:Lazy
```

---

## 📝 よくある質問

**Q: ホームディレクトリ全体がGitリポジトリになってる（dotfiles管理）**
```
A: 問題なし。サブディレクトリに別の.gitがあれば、
   そちらが優先される。
```

**Q: .git/ を削除したのにまだマークが出る**
```
A: Neovimを再起動するか、:edit で再読み込み
```

**Q: NeoTreeやnvim-treeで開いたファイルでGitが効かない**
```
A: ファイルツリープラグインの設定を確認。
   通常は自動で動作するはず。
```

**Q: リモートサーバー（SSH）でGitが動かない**
```
A: サーバー側にgitコマンドがインストールされているか確認
   which git
```

---

## 🎯 ベストプラクティス

### 1. プロジェクトごとにターミナルタブを分ける

```bash
# ターミナルタブ1: プロジェクトA
cd ~/project-a
nvim .

# ターミナルタブ2: プロジェクトB
cd ~/project-b
nvim .
```

### 2. tmux や zellij を使う

```bash
# セッション管理ツールで複数プロジェクトを管理
tmux new -s project-a
cd ~/project-a && nvim .

# 別ウィンドウ
tmux new -s project-b
cd ~/project-b && nvim .
```

### 3. Neovim起動時のカレントディレクトリを意識する

```bash
# ❌ よくない
cd /tmp
nvim ~/myproject/src/main.rb  # カレントディレクトリが/tmp

# ✅ 良い
cd ~/myproject
nvim src/main.rb  # カレントディレクトリがプロジェクトルート
```

---

## 🚀 次のステップ

問題が解決しない場合：

1. **ログを確認**
   ```vim
   :messages  " Neovim内でエラーメッセージ確認
   ```

2. **gitsignsのログを有効化**
   ```lua
   -- lua/plugins/git-signs.lua に追加
   debug_mode = true,  -- デバッグモード有効化
   ```

3. **Issue報告**
   - https://github.com/lewis6991/gitsigns.nvim/issues
