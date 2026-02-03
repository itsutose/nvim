# Vimの不満点への解決策

このドキュメントは`fuck_vim.md`で挙げた問題点への解決策をまとめています。

## ✅ 解決済み

### 1. 日本語入力との相性問題

**問題**: Insert mode中、日本語入力時に`jj`で「っj」になる

**解決策**:
```
左Control（物理キー = 英数キー論理）を押す
→ Ctrl+[ が送信される（vim標準のEsc）
→ 強制的にNormal mode
→ im-selectが自動で英数入力に切り替え
```

**設定場所**: `lua/keymaps.lua` (18-22行目)
```lua
map({'i', 'v', 'c'}, '<C-[>', '<Esc>', {
  noremap = true,
  silent = true,
  desc = '強制的にNormal mode（日本語入力中も可）'
})
```

### 2. Insert mode中の移動が不便

**問題**: Insert mode中に移動するには一度Normal modeに戻る必要がある

**解決策**:
```
かなキー + i/j/k/l → 矢印キー（Karabinerで既に設定済み）
Ctrl + a → 行頭
Ctrl + e → 行末
Ctrl + f → 次の単語
Ctrl + b → 前の単語
Ctrl + w → 単語削除
```

**設定場所**: `lua/keymaps.lua` (40-60行目)

### 3. インデント操作が面倒

**問題**: VSCodeのようにTabキー1つでインデントしたい

**解決策**:
```
Insert mode中: Shift+Tab でインデント削除
Visual mode: < でインデント削除、> でインデント追加
Normal mode: >> でインデント追加、<< でインデント削除
```

**設定場所**: `lua/keymaps.lua` (114-124行目)

### 4. Visual mode中の行頭・行末移動

**問題**: `v`で起動した後に行頭・行末に行きたい

**解決策**:
```
Shift+H → 行頭
Shift+L → 行末
Ctrl+h → 行頭
Ctrl+; → 行末
```

**設定場所**: `lua/keymaps.lua` (25-38行目)

---

## 💡 質問への回答

### Q1: command, control, shiftは左右で区別できるか？

**A: Yes、できます。**

Karabinerで既に使用中:
- `left_control` → `japanese_eisuu`（英数入力切り替え）
- `right_control`（かなキー変換後） → ショートカットキー

nvim側でも区別可能:
```lua
map('n', '<Left-Cmd>h', ...) -- 左Command
map('n', '<Right-Cmd>h', ...) -- 右Command
```

### Q2: normalでのw, e, bについて

**問題**: bが打ちづらい

**解決策の選択肢**:

1. **慣れる**（標準的）
   - w, e, b はvim標準の単語移動
   - 使用頻度: w > e > b

2. **代替キーを設定**
   ```lua
   -- 例: Shift+Bをbに
   map('n', '<S-B>', 'b', { desc = '前の単語へ' })
   ```

3. **f/t（文字ジャンプ）を活用**
   ```vim
   f{char}  " 次の{char}へジャンプ
   t{char}  " 次の{char}の手前へ
   ;        " 繰り返し
   ,        " 逆方向
   ```
   これの方が実は速い！

### Q3: Insert/Normal mode中のBS, Del

**A: vim標準で既にサポートされています。**

```vim
Insert mode:
  Backspace → 前の文字削除
  Ctrl+h    → Backspace（vim標準）
  Ctrl+w    → 単語削除（vim標準）

Normal mode:
  x   → カーソル下の文字削除（Del相当）
  X   → カーソル前の文字削除（BS相当）
  dw  → 単語削除
  dd  → 行削除
```

**Karabinerで既に設定済み**:
```
right_control + u → Backspace
right_control + o → Delete
```

これは全モードで使えます！

### Q4: o, oで2行改行したい

**問題**: `o, o`ではダメで、`o, Enter`が必要

**解決策**:
```lua
-- oを2回押すとEnter追加
map('n', 'oo', 'o<Esc>o', { noremap = true, desc = '2行改行' })
```

または:
```vim
" Normal mode:
o        " 1行改行
Enter    " その行でEnter（Insert mode中）
```

---

## 🎯 設定ファイル構成

### 統合されたファイル構成
```
nvim/
├── init.lua              # エントリーポイント
├── lua/
│   ├── base.lua          # vimオプション設定のみ
│   ├── keymaps.lua       # 全てのキーマップ（ここに集約）✅
│   ├── ime.lua           # IME自動化（autocmdのみ）
│   └── plugins/          # プラグイン設定（1ファイル1プラグイン）
│       ├── which-key.lua
│       ├── cmp.lua
│       └── ...
```

### なぜこの構成？

1. **keymaps.luaに全て集約**
   - 管理しやすい
   - セクションごとにコメント分け
   - 検索しやすい

2. **ファイル分割しすぎない**
   - `lua/mode-switch.lua` ❌
   - `lua/insert-enhance.lua` ❌
   - `lua/jikl-remap.lua` ❌
   → 全てkeymaps.luaに統合 ✅

3. **プラグインは分離**
   - `lua/plugins/*.lua`
   - 1ファイル1プラグイン
   - lazy.nvimの推奨構成

---

## 📚 今後の拡張

### プラグイン候補（必要に応じて）

1. **Markdown表示**
   ```lua
   -- lua/plugins/markdown.lua
   return {
     'MeanderingProgrammer/render-markdown.nvim',
     -- ハイライト、折りたたみ、整形
   }
   ```

2. **キーバインド可視化**
   - `which-key.nvim` → 既にインストール済み ✅
   - Spaceキーを押すと候補が表示される

3. **より高度なIME連携**
   - `im-select.nvim` → 既に設定済み ✅

---

## 🧪 動作確認

### テスト項目

1. ✅ 日本語入力中に左Controlを押してNormal modeへ
2. ✅ Insert mode中にかなキー+ijklで移動
3. ✅ Insert mode中にCtrl+a/eで行頭・行末
4. ✅ Visual mode中にaキーでInsert mode
5. ✅ Shift+TabでInsertインデント削除

---

## 📝 メモ

- 全てのキーマップは`lua/keymaps.lua`で管理
- プラグイン追加は`lua/plugins/`に1ファイルずつ
- 設定変更後は`:source %`または`:Lazy reload`で反映
- キーマップ確認: `:map <キー>` または which-keyのポップアップ
