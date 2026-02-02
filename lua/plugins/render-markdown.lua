-- ============================================================================
-- render-markdown.nvim - Markdownをいい感じに表示
-- ============================================================================
-- Plain textのMarkdownファイルを読みやすく整形表示
-- - 見出し: 階層ごとに色分け・アイコン表示
-- - コードブロック: 背景色付きで表示
-- - チェックボックス: □ ☑ アイコン化
-- - テーブル: 罫線を綺麗に整形
-- - リスト: 階層ごとにアイコン変更
-- - 折りたたみ: 見出し単位で折りたたみ可能

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",  -- Markdownファイルを開いた時だけロード
  dependencies = {
    "nvim-treesitter/nvim-treesitter",  -- 構文解析
    "nvim-tree/nvim-web-devicons",      -- アイコン表示
  },
  config = function()
    require("render-markdown").setup({
      -- 見出しの設定
      heading = {
        enabled = true,
        sign = true,  -- サイン列にアイコン表示
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },  -- 見出しアイコン
        -- 見出しの背景色を設定
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
      },

      -- コードブロックの設定
      code = {
        enabled = true,
        sign = true,  -- サイン列にアイコン表示
        style = "full",  -- full | normal | language
        left_pad = 2,  -- 左の余白
        right_pad = 2,  -- 右の余白
        width = "block",  -- block | full
        border = "thin",  -- thin | thick
      },

      -- チェックボックスの設定
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },  -- □
        checked = { icon = "󰱒 " },    -- ☑
      },

      -- 箇条書きリストの設定
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },  -- 階層ごとに変える
      },

      -- テーブルの設定
      pipe_table = {
        enabled = true,
        style = "full",  -- full | normal | none
      },

      -- リンクの設定
      link = {
        enabled = true,
        image = "󰥶 ",  -- 画像リンクのアイコン
        hyperlink = "󰌹 ",  -- ハイパーリンクのアイコン
      },
    })
  end,
  keys = {
    -- トグル用のキーマップ（オン/オフ切り替え）
    {
      "<leader>mr",
      "<cmd>RenderMarkdown toggle<cr>",
      desc = "Markdown Renderingトグル",
      ft = "markdown",
    },
  },
}
