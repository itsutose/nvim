return {
  'petertriho/nvim-scrollbar',
  event = 'VeryLazy',
  dependencies = {
    'kevinhwang91/nvim-hlslens',
  },
  config = function()
    require('scrollbar').setup({
      -- スクロールバーの表示設定
      show = true,
      show_in_active_only = false,
      set_highlights = true,

      -- ファイル全体が画面に収まる場合は非表示
      hide_if_all_visible = true,

      -- 除外するバッファタイプ
      excluded_buftypes = {
        'terminal',
        'prompt',
      },

      -- 除外するファイルタイプ
      excluded_filetypes = {
        'neo-tree',
        'NvimTree',
        'TelescopePrompt',
      },

      -- スクロールバーの見た目
      handle = {
        text = '┃',
        color = nil, -- カラースキームに自動適応
        hide_if_all_visible = true,
      },

      -- マーカー表示（検索結果、診断、Git差分など）
      marks = {
        Search = { text = { '-', '=' }, priority = 0, color = nil },
        Error = { text = { '-', '=' }, priority = 1, color = nil },
        Warn = { text = { '-', '=' }, priority = 2, color = nil },
        Info = { text = { '-', '=' }, priority = 3, color = nil },
        Hint = { text = { '-', '=' }, priority = 4, color = nil },
        Misc = { text = { '-', '=' }, priority = 5, color = nil },
        GitAdd = { text = '┃', priority = 6, color = nil },
        GitChange = { text = '┃', priority = 7, color = nil },
        GitDelete = { text = '_', priority = 8, color = nil },
      },

      -- ハンドラー（他のプラグインとの統合）
      handlers = {
        cursor = true,      -- カーソル位置を表示
        diagnostic = true,  -- LSP診断を表示
        gitsigns = true,    -- Git差分を表示（gitsignsプラグインが必要）
        handle = true,      -- スクロールバー本体
        search = true,      -- 検索結果を表示
      },
    })
  end,
}
