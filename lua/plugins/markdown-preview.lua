-- ============================================================================
-- markdown-preview.nvim - ブラウザでMarkdownライブプレビュー
-- ============================================================================
-- ここに何か書き込めるか？
-- 画像・テーブル・mermaid・LaTeX等を確実にレンダリング
-- render-markdownで表示が不完全な場合のフォールバック

return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  build = "cd app && npm install",  -- 初回インストール時にビルド
  config = function()
    vim.g.mkdp_auto_close = 1       -- バッファを離れたら自動でブラウザを閉じる
    vim.g.mkdp_refresh_slow = 0     -- リアルタイム更新
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown ブラウザプレビュー", ft = "markdown" },
  },
} 
