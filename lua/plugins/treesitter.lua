return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    -- Treesitterは新しいAPIを使用
    vim.treesitter.language.register('markdown', 'md')
  end
}
