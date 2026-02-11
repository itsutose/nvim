-- ============================================================================
-- Filetype-specific Settings
-- ============================================================================
-- ファイルタイプ固有の設定を集約

-- ============================================================================
-- Wrap設定（ファイルタイプ別）
-- ============================================================================

-- wrapを有効にするファイルタイプ
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "help" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true  -- 単語の途中で折り返さない
    vim.opt_local.breakindent = true  -- 折り返し行のインデントを維持
  end,
})

-- wrapを無効にするファイルタイプ（明示的に）
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "python", "typescript", "javascript", "go", "json" },
  callback = function()
    vim.opt_local.wrap = false
  end,
})
