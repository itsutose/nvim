-- ============================================================================
-- Neovim Keymaps Configuration
-- ============================================================================
-- 全てのカスタムキーマップをここに集約
-- セクションごとに整理して管理

local map = vim.keymap.set

-- ============================================================================
-- 1. モード切り替え（最重要）
-- ============================================================================

-- Ctrl+c で確実に Normal mode へ（日本語入力中でも動作）
-- im-selectにより自動的に英数入力に切り替わる
map('i', '<C-c>', '<Esc>', {
  noremap = true,
  silent = true,
  desc = 'Normal modeへ（日本語入力中OK・英数自動切替）'
})
map('v', '<C-c>', '<Esc>', {
  noremap = true,
  silent = true,
  desc = 'Normal modeへ'
})

-- -- ============================================================================
-- -- 2. 行頭・行末移動
-- -- ============================================================================

-- -- Ctrl+h で行頭、Ctrl+; で行末
-- map('n', '<C-h>', '^', { noremap = true, silent = true, desc = '行頭へ' })
-- map('n', '<C-;>', '$', { noremap = true, silent = true, desc = '行末へ' })
-- map('v', '<C-h>', '^', { noremap = true, silent = true, desc = '行頭へ' })
-- map('v', '<C-;>', '$', { noremap = true, silent = true, desc = '行末へ' })

-- -- Shift+H で行頭、Shift+L で行末（代替）
-- map('n', '<S-H>', '^', { noremap = true, silent = true, desc = '行頭へ' })
-- map('n', '<S-L>', '$', { noremap = true, silent = true, desc = '行末へ' })
-- map('v', '<S-H>', '^', { noremap = true, silent = true, desc = '行頭へ' })
-- map('v', '<S-L>', '$', { noremap = true, silent = true, desc = '行末へ' })

-- -- ============================================================================
-- -- 3. Insert mode 拡張
-- -- ============================================================================
-- -- Insert mode中でもカーソル移動や編集ができるように
-- -- 注: かなキー+ijkl は既にKarabinerで矢印キーになっている

-- -- 行頭・行末へ移動
-- map('i', '<C-a>', '<C-o>^', { noremap = true, desc = 'Insert中に行頭へ' })
-- map('i', '<C-e>', '<C-o>$', { noremap = true, desc = 'Insert中に行末へ' })

-- -- 単語移動
-- map('i', '<C-.>', 'w', { noremap = true, desc = 'Insert中に次の単語へ' })
-- map('i', '<C-,>', 'b', { noremap = true, desc = 'Insert中に前の単語へ' })

-- -- 単語削除
-- map('i', '<C-w>', '<C-o>diw', { noremap = true, desc = 'Insert中に単語削除' })

-- -- Backspace, Delete（vim標準のままでも動作するが明示的に）
-- -- map('i', '<C-h>', '<BS>', { noremap = true, desc = 'Backspace' })
-- -- map('i', '<C-d>', '<Del>', { noremap = true, desc = 'Delete' })
-- -- 注: Ctrl+hは行頭移動と衝突するのでコメントアウト

-- -- ============================================================================
-- -- 4. Visual mode 拡張
-- -- ============================================================================

-- -- Visual modeから Insert modeへ（選択解除して入力開始）
-- map('v', 'a', '<Esc>i', { noremap = true, desc = 'Visual→Insert mode' })

-- -- ============================================================================
-- -- 5. Normal mode 便利機能
-- -- ============================================================================

-- -- 検索ハイライト解除
-- map('n', '<Esc><Esc>', ':nohlsearch<CR>', {
--   noremap = true,
--   silent = true,
--   desc = '検索ハイライト解除'
-- })

-- -- 保存・終了
-- map('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true, desc = '保存' })
-- map('n', '<Leader>q', ':q<CR>', { noremap = true, silent = true, desc = '終了' })
-- map('n', '<Leader>x', ':x<CR>', { noremap = true, silent = true, desc = '保存して終了' })

-- -- ============================================================================
-- -- 6. ウィンドウ操作
-- -- ============================================================================
-- -- Ctrl+h は行頭移動に使っているので、Leader+w プレフィックスを使用

-- map('n', '<Leader>wh', '<C-w>h', { noremap = true, desc = '左のウィンドウへ' })
-- map('n', '<Leader>wj', '<C-w>j', { noremap = true, desc = '下のウィンドウへ' })
-- map('n', '<Leader>wk', '<C-w>k', { noremap = true, desc = '上のウィンドウへ' })
-- map('n', '<Leader>wl', '<C-w>l', { noremap = true, desc = '右のウィンドウへ' })
-- map('n', '<Leader>ww', '<C-w>w', { noremap = true, desc = '次のウィンドウへ' })
-- map('n', '<Leader>wc', '<C-w>c', { noremap = true, desc = 'ウィンドウを閉じる' })
-- map('n', '<Leader>ws', '<C-w>s', { noremap = true, desc = '水平分割' })
-- map('n', '<Leader>wv', '<C-w>v', { noremap = true, desc = '垂直分割' })

-- -- ============================================================================
-- -- 7. バッファ・タブ操作
-- -- ============================================================================

-- -- バッファ移動
-- map('n', '<Leader>bn', ':bnext<CR>', { noremap = true, silent = true, desc = '次のバッファ' })
-- map('n', '<Leader>bp', ':bprevious<CR>', { noremap = true, silent = true, desc = '前のバッファ' })
-- map('n', '<Leader>bd', ':bdelete<CR>', { noremap = true, silent = true, desc = 'バッファを閉じる' })

-- -- タブ移動
-- map('n', '<Leader>tn', ':tabnext<CR>', { noremap = true, silent = true, desc = '次のタブ' })
-- map('n', '<Leader>tp', ':tabprevious<CR>', { noremap = true, silent = true, desc = '前のタブ' })
-- map('n', '<Leader>tc', ':tabclose<CR>', { noremap = true, silent = true, desc = 'タブを閉じる' })
-- map('n', '<Leader>to', ':tabonly<CR>', { noremap = true, silent = true, desc = '他のタブを全て閉じる' })

-- -- ============================================================================
-- -- 8. インデント操作（Insert mode中も可能に）
-- -- ============================================================================

-- -- Insert mode中のインデント操作
-- map('i', '<S-Tab>', '<C-d>', { noremap = true, desc = 'Insert中にインデント削除' })
-- -- 注: Tabキーは補完候補選択に使われる可能性があるので注意

-- -- Visual modeでインデント後も選択を維持
-- map('v', '<', '<gv', { noremap = true, desc = 'インデント削除（選択維持）' })
-- map('v', '>', '>gv', { noremap = true, desc = 'インデント追加（選択維持）' })

-- -- ============================================================================
-- -- 9. Command mode 便利機能
-- -- ============================================================================

-- -- Command mode中の行頭・行末移動
-- map('c', '<C-a>', '<Home>', { noremap = true, desc = 'コマンド行の先頭へ' })

-- ============================================================================
-- 10. コメントアウト
-- ============================================================================
-- 注: comment.nvim プラグインに依存
-- Ghosttyで Cmd+/ を F13 に変換して送信
-- マッピングは lua/plugins/comment.lua 内で設定（プラグインロード後に設定する必要があるため）

-- ============================================================================
-- 11. Undo/Redo（Cmd+Z / Cmd+Shift+Z）
-- ============================================================================
-- Ghosttyで Cmd+Z → F14, Cmd+Shift+Z → F15 に変換して送信
-- tmux内外で両方動作するように、複数のキーコードをマッピング

-- Undo (Cmd+Z)
-- tmux外: F14 (\x1b[26~) → <F14>として認識される
map('n', '<F14>', 'u', { noremap = true, silent = true, desc = 'Undo (Cmd+Z)' })
map('i', '<F14>', '<Esc>ui', { noremap = true, silent = true, desc = 'Undo (Cmd+Z)' })

-- tmux内: F14 → Neovimが<S-F4>として解釈
map('n', '<S-F4>', 'u', { noremap = true, silent = true, desc = 'Undo (Cmd+Z via tmux)' })
map('i', '<S-F4>', '<Esc>ui', { noremap = true, silent = true, desc = 'Undo (Cmd+Z via tmux)' })

-- Redo (Cmd+Shift+Z)
-- tmux外: F15 (\x1b[28~) → <F15>として認識される
map('n', '<F15>', '<C-r>', { noremap = true, silent = true, desc = 'Redo (Cmd+Shift+Z)' })
map('i', '<F15>', '<Esc><C-r>i', { noremap = true, silent = true, desc = 'Redo (Cmd+Shift+Z)' })

-- tmux内: F15 → Neovimが<S-F5>として解釈
map('n', '<S-F5>', '<C-r>', { noremap = true, silent = true, desc = 'Redo (Cmd+Shift+Z via tmux)' })
map('i', '<S-F5>', '<Esc><C-r>i', { noremap = true, silent = true, desc = 'Redo (Cmd+Shift+Z via tmux)' })

-- ============================================================================
-- Backspace（削除キー）の動作設定
-- ============================================================================
-- Karabinerで right_ctrl+u → backspace に変換される
-- Normal/Visual modeでも削除として機能するように設定
-- 全ての削除操作でブラックホールレジスタ("_)を使用し、レジスタを汚染しない

-- Normal mode: backspaceで前の文字を削除（レジスタに入れない）
map('n', '<BS>', '"_X', { noremap = true, silent = true, desc = 'カーソル前の文字を削除 (right_ctrl+u)' })

-- Visual mode: backspaceで選択範囲を削除（レジスタに入れない）
map('v', '<BS>', '"_x', { noremap = true, silent = true, desc = '選択範囲を削除 (right_ctrl+u)' })

-- Ctrl+U を全モードでBackspace（削除）として機能させる
-- 標準のCtrl+U動作（Insert:行頭まで削除、Normal:スクロール）を上書き
-- レジスタを汚染せず純粋な削除のみ

-- Insert mode: Ctrl+U で1文字削除（Backspace相当）
map('i', '<C-u>', '<BS>', { noremap = true, silent = true, desc = '1文字削除 (Ctrl+U)' })

-- Normal mode: Ctrl+U でカーソル前の文字を削除（レジスタに入れない）
map('n', '<C-u>', '"_X', { noremap = true, silent = true, desc = 'カーソル前の文字を削除 (Ctrl+U)' })

-- Visual mode: Ctrl+U で選択範囲を削除（レジスタに入れない）
map('v', '<C-u>', '"_x', { noremap = true, silent = true, desc = '選択範囲を削除 (Ctrl+U)' })

-- Shift+Del で一行削除（Ctrl+Uの拡張版）
-- レジスタを汚染せず純粋な削除のみ

-- Insert mode: Shift+Del で現在行を削除してInsert modeに戻る（レジスタに入れない）
map('i', '<S-Del>', '<Esc>"_ddi', { noremap = true, silent = true, desc = '一行削除 (Shift+Del)' })

-- Normal mode: Shift+Del で現在行を削除（レジスタに入れない）
map('n', '<S-Del>', '"_dd', { noremap = true, silent = true, desc = '一行削除 (Shift+Del)' })

-- Visual mode: Shift+Del で選択行を削除（レジスタに入れない）
map('v', '<S-Del>', '"_d', { noremap = true, silent = true, desc = '選択行を削除 (Shift+Del)' })

-- -- ============================================================================
-- -- 12. その他便利機能
-- -- ============================================================================

-- -- Y を行末までヤンク（vim標準では yy と同じだが、D や C と統一）
-- map('n', 'Y', 'y$', { noremap = true, desc = '行末までヤンク' })

-- -- 貼り付け後にカーソルを末尾に移動
-- map('n', 'gp', 'p`]', { noremap = true, desc = '貼り付け後にカーソルを末尾へ' })
-- map('n', 'gP', 'P`]', { noremap = true, desc = '貼り付け後にカーソルを末尾へ' })

-- ============================================================================
-- 12. ウィンドウ終了（スペース + q/Q）
-- ============================================================================
-- 自動保存があるので :q だけで終了できる
-- スペースキーで更に素早く終了

-- カレントウィンドウを閉じる
map('n', '<leader>q', ':q<CR>', {
  noremap = true,
  silent = true,
  desc = 'カレントウィンドウを閉じる'
})

-- 全てのウィンドウを閉じる（Nvim終了）
map('n', '<leader>Q', ':qa<CR>', {
  noremap = true,
  silent = true,
  desc = '全ウィンドウを閉じる（Nvim終了）'
})

-- ============================================================================
-- 13. テーマ切り替え
-- ============================================================================
-- プレビュー付きでテーマを選択できる

-- テーマ選択画面を開く（プレビュー付き）
map('n', '<leader>tc', '<cmd>Telescope colorscheme<cr>', {
  noremap = true,
  silent = true,
  desc = 'テーマ選択（プレビュー付き）'
})

-- よく使うテーマへのクイック切り替え
map('n', '<leader>t1', '<cmd>colorscheme catppuccin<cr>', {
  noremap = true,
  silent = true,
  desc = 'Catppuccin（黒強め）'
})

map('n', '<leader>t2', '<cmd>colorscheme tokyonight<cr>', {
  noremap = true,
  silent = true,
  desc = 'Tokyonight（元のテーマ）'
})

map('n', '<leader>t3', '<cmd>colorscheme carbonfox<cr>', {
  noremap = true,
  silent = true,
  desc = 'Carbonfox（炭のような黒）'
})

map('n', '<leader>t4', '<cmd>colorscheme onedark<cr>', {
  noremap = true,
  silent = true,
  desc = 'One Dark（暗めバランス型）'
})

map('n', '<leader>t5', '<cmd>colorscheme monokai-pro<cr>', {
  noremap = true,
  silent = true,
  desc = 'Monokai Pro（ビビッド）'
})

map('n', '<leader>t6', '<cmd>colorscheme sonokai<cr>', {
  noremap = true,
  silent = true,
  desc = 'Sonokai（Monokai進化版）'
})

map('n', '<leader>t7', '<cmd>colorscheme material<cr>', {
  noremap = true,
  silent = true,
  desc = 'Material（Googleデザイン）'
})

map('n', '<leader>t8', '<cmd>colorscheme everforest<cr>', {
  noremap = true,
  silent = true,
  desc = 'Everforest（緑系）'
})

map('n', '<leader>t9', '<cmd>colorscheme vscode<cr>', {
  noremap = true,
  silent = true,
  desc = 'VSCode Dark+（VSCode再現）'
})

map('n', '<leader>t0', '<cmd>colorscheme ayu-dark<cr>', {
  noremap = true,
  silent = true,
  desc = 'Ayu（シンプル）'
})

-- ============================================================================
-- End of Keymaps
-- ============================================================================


