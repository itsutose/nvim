-- Pythonのハイライトが強いカラースキーム集
return {
  -- Tokyo Night（Python向けに最適化）
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- night, storm, day, moon
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
          functions = { bold = true },
          variables = {},
        },
        on_highlights = function(hl, c)
          -- 変数を明示的に青く
          hl["@variable"] = { fg = c.blue0 }
          hl["@variable.parameter"] = { fg = c.orange }
          -- 関数呼び出しを黄色く
          hl["@function.call"] = { fg = c.yellow }
          hl["@method.call"] = { fg = c.yellow }
          -- クラスを緑系に
          hl["@type"] = { fg = c.green, bold = true }
          hl["@constructor"] = { fg = c.yellow }
        end,
      })
    end,
  },

  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = { bold = true },
        keywordStyle = { italic = false },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
          return {
            ["@function.call"] = { fg = colors.palette.carpYellow, bold = true },
            ["@variable"] = { fg = colors.palette.crystalBlue },
            ["@variable.parameter"] = { fg = colors.palette.oniViolet },
          }
        end,
      })
    end,
  },

  -- Catppuccin (鮮やかなハイライト設定）
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",  -- mocha, macchiato, frappe, latte
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = { "bold" },
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = { "bold" },
        },
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
        },
        custom_highlights = function(colors)
          return {
            -- 1. 変数 (url, res, soup など) を青くする
            ["@variable"] = { fg = colors.blue },
            ["@variable.builtin"] = { fg = colors.red },
            ["@variable.parameter"] = { fg = colors.maroon },
            ["@property"] = { fg = colors.blue }, -- self.bm_code のようなプロパティ

            -- 2. 関数呼び出し (BeautifulSoup, find, must_get_tag など) を黄色にする
            ["@function.call"] = { fg = colors.yellow },
            ["@method.call"] = { fg = colors.yellow },
            ["@function.builtin"] = { fg = colors.peach },

            -- 3. クラス名や型 (tuple, str など) を緑〜黄色にする
            ["@type"] = { fg = colors.yellow, style = { "bold" } },
            ["@type.builtin"] = { fg = colors.yellow },
            ["@constructor"] = { fg = colors.yellow }, -- BeautifulSoup() のようなコンストラクタ

            -- 4. 演算子 (=, +, == など) に色をつける
            ["@operator"] = { fg = colors.sky },

            -- 5. キーワードを紫で
            ["@keyword"] = { fg = colors.mauve },

            -- 6. 文字列をより鮮やかに
            ["@string"] = { fg = colors.green },

            -- 7. 関数定義を太字+黄色に
            ["@function"] = { fg = colors.yellow, style = { "bold" } },
          }
        end,
      })
    end,
  },

  -- Carbonfox（炭のような黒）
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Monokai Pro（Sublime Text風）
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup()
    end
  },

  -- Sonokai（Monokai進化版）
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = 'andromeda'  -- default, atlantis, andromeda, shusia, maia, espresso
    end
  },

  -- VSCode Dark+（VSCode再現）
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('vscode').setup({
        style = 'dark',
        group_overrides = {
          GitSignsAddLn = { bg = "#2a3a20" },
          GitSignsChangeLn = { bg = "#2a2a1a" },
          GitSignsDeleteLn = { bg = "#3a1a1a" },
        },
      })
    end
  },
}
