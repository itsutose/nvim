return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { "<leader>p", "<cmd>Telescope find_files<cr>", desc = "Telescope find_files" },
    { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep" },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        -- シンプルなプレビュー設定
        preview = {
          treesitter = false,
        },
        -- ripgrepのパスを明示的に指定（aliasを回避）
        vimgrep_arguments = {
          '/opt/homebrew/bin/rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
      },
    })
  end,
}
