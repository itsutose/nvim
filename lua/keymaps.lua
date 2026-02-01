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

-- Normal mode: Undo/Redo
map('n', '<F14>', 'u', { noremap = true, silent = true, desc = 'Undo (Cmd+Z)' })
map('n', '<F15>', '<C-r>', { noremap = true, silent = true, desc = 'Redo (Cmd+Shift+Z)' })

-- Insert mode: Escapeしてから Undo/Redo、その後Insert modeに戻る
map('i', '<F14>', '<Esc>ui', { noremap = true, silent = true, desc = 'Undo (Cmd+Z)' })
map('i', '<F15>', '<Esc><C-r>i', { noremap = true, silent = true, desc = 'Redo (Cmd+Shift+Z)' })


map('n', '<D-/>', 'gcc', { noremap = false, desc = 'コメントトグル' })
map('v', '<D-/>', 'gc', { noremap = false, desc = 'コメントトグル' })

