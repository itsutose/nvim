return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      version = '^1.0.0',
    },
  },
  keys = {
    { "<leader>p", "<cmd>Telescope find_files<cr>", desc = "Telescope find_files" },
    { "<leader>g", function()
      require('telescope').extensions.live_grep_args.live_grep_args()
    end, desc = "Live grep (with args)" },
  },
  config = function()
    local telescope = require('telescope')
    local lga_actions = require('telescope-live-grep-args.actions')

    telescope.setup({
      defaults = {
        preview = {
          treesitter = false,
        },
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
      extensions = {
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
            },
          },
        },
      },
    })

    telescope.load_extension('live_grep_args')
  end,
}
