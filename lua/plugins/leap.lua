-- ============================================================================
-- leap.nvim - 軽量EasyMotion代替
-- ============================================================================
-- 画面内の任意の位置へ2文字入力で瞬時に移動
-- sで前方、Sで後方（双方向も可能）

return {
  url = "https://codeberg.org/andyg/leap.nvim",
  dependencies = { "tpope/vim-repeat" }, -- ドットリピート対応
  config = function()
    local leap = require('leap')

    -- デフォルトキーマップを設定
    leap.add_default_mappings()

    -- カスタマイズ（お好みで）
    -- leap.opts.case_sensitive = false  -- 大文字小文字を区別しない
    -- leap.opts.safe_labels = {}  -- 安全ラベルを無効化（全ラベル使用）
  end,
  keys = {
    -- sで前方検索、Sで後方検索（デフォルト）
    -- gs で全ウィンドウを対象に検索
    { "s", mode = { "n", "x", "o" }, desc = "Leap forward" },
    { "S", mode = { "n", "x", "o" }, desc = "Leap backward" },
    { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
  },
}
