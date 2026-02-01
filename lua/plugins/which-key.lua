return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- timeoutlenはbase.luaで一元管理
  config = function()
    local wk = require("which-key")

    wk.setup({
      -- ポップアップの見た目
      plugins = {
        marks = true,     -- マーク表示
        registers = true, -- レジスタ表示
        spelling = {
          enabled = false, -- スペルチェック候補は無効
        },
        presets = {
          operators = false,    -- オペレータは表示しない
          motions = false,      -- モーションは表示しない
          text_objects = false, -- テキストオブジェクトは表示しない
          windows = true,       -- ウィンドウコマンドは表示
          nav = true,           -- ナビゲーション
          z = true,             -- z系コマンド
          g = true,             -- g系コマンド
        },
      },
      -- アイコン設定
      icons = {
        breadcrumb = "»", -- パンくずリスト
        separator = "➜", -- 区切り文字
        group = "+",      -- グループ
      },
      -- ポップアップウィンドウの設定
      win = {
        border = "rounded",   -- 枠線のスタイル
        padding = { 1, 2 },   -- パディング
      },
      layout = {
        height = { min = 4, max = 25 }, -- 高さ
        width = { min = 20, max = 50 }, -- 幅
        spacing = 3,                    -- スペース
        align = "left",                 -- 左寄せ
      },
    })

    -- キーマップのグループ名を登録
    wk.add({
      -- Git操作グループ
      { "<leader>g", group = "Git" },
      { "<leader>gg", desc = "LazyGit起動" },
      { "<leader>gf", desc = "ファイル履歴" },

      -- Git Hunk操作グループ
      { "<leader>h", group = "Git Hunk" },
      { "<leader>hs", desc = "ステージング" },
      { "<leader>hr", desc = "変更を戻す" },
      { "<leader>hu", desc = "アンステージング" },
      { "<leader>hp", desc = "プレビュー" },
      { "<leader>hb", desc = "Blame表示" },
      { "<leader>hd", desc = "差分表示" },
      { "<leader>hD", desc = "HEAD比較" },
      { "<leader>hS", desc = "ファイル全体ステージ" },
      { "<leader>hR", desc = "ファイル全体を戻す" },

      -- Toggle操作グループ
      { "<leader>t", group = "Toggle" },
      { "<leader>tb", desc = "Blame自動表示" },

      -- ファイル操作（将来追加用）
      { "<leader>f", group = "File/Find" },

      -- バッファ操作（将来追加用）
      { "<leader>b", group = "Buffer" },

      -- ウィンドウ操作（将来追加用）
      { "<leader>w", group = "Window" },
    })

    -- ビジュアルモード用のキーマップ
    wk.add({
      mode = { "v" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>hs", desc = "ステージング（範囲）" },
      { "<leader>hr", desc = "変更を戻す（範囲）" },
      { "<leader>hu", desc = "アンステージング（範囲）" },
    })
  end,
}
