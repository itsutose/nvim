-- ============================================================================
-- Theme - カラースキーム設定
-- ============================================================================
-- 複数のテーマをインストールして、簡単に切り替え可能にする
--
-- 切り替え方法:
--   :colorscheme catppuccin       → 黒色強め（デフォルト）
--   :colorscheme tokyonight       → 元のテーマ
--   :colorscheme carbonfox        → 炭のような黒
--   :colorscheme onedark          → 暗めのバランス型
--
-- または <leader>tc でテーマ選択画面を開く

return {
  -- 1. Catppuccin（黒色強め、デフォルト）
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = { light = "latte", dark = "mocha" },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
        color_overrides = {
          mocha = {
            base = "#0d0d0d",
            mantle = "#0a0a0a",
            crust = "#000000",
          },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          telescope = { enabled = true },
          markdown = true,
        },
      })

      -- デフォルトテーマとして設定
      vim.cmd.colorscheme("catppuccin")
    end
  },

  -- 2. Tokyonight（元のテーマ）
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("tokyonight").setup({
        style = "storm",  -- storm, moon, night
      })
      -- デフォルトでは読み込まない（手動切り替え用）
    end
  },

  -- 3. Carbonfox（炭のような黒）
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 998,
  },

  -- 4. One Dark（暗めのバランス型）
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 997,
    config = function()
      require('onedark').setup({
        style = 'darker',
      })
    end
  },
}

-- ============================================================================
-- 他のテーマ候補（コメントアウト）
-- ============================================================================
-- 試したい場合は上記と入れ替える

-- Carbonfox（炭のような黒）
-- return {
--   "EdenEast/nightfox.nvim",
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme("carbonfox")
--   end
-- }

-- One Dark Darker（非常に暗い）
-- return {
--   "navarasu/onedark.nvim",
--   priority = 1000,
--   config = function()
--     require('onedark').setup({ style = 'darker' })
--     require('onedark').load()
--   end
-- }

-- Tokyonight Night（現在のテーマの暗いバージョン）
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("tokyonight").setup({ style = "night" })
--     vim.cmd.colorscheme("tokyonight-night")
--   end
-- }
