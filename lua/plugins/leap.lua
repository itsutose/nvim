-- ============================================================================
-- leap.nvim - 軽量EasyMotion代替
-- ============================================================================
-- 画面内の任意の位置へ2文字入力で瞬時に移動
-- sで前方、Sで後方（双方向も可能）

return {
  url = "https://codeberg.org/andyg/leap.nvim",
  dependencies = { "tpope/vim-repeat" }, -- ドットリピート対応
  event = "VeryLazy",  -- Nvim起動後すぐにロード
  config = function()
    local leap = require('leap')

    -- 手動でキーマップを設定
    vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
    vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')

    -- カスタマイズ（お好みで）
    -- leap.opts.case_sensitive = false  -- 大文字小文字を区別しない
    -- leap.opts.safe_labels = {}  -- 安全ラベルを無効化（全ラベル使用）
  end,
}
