return {
  "mikavilpas/yazi.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    {
      "<leader>e",
      "<cmd>Yazi<cr>",
      desc = "Yazi: カレントファイル",
    },
    {
      "<leader>E",
      "<cmd>Yazi cwd<cr>",
      desc = "Yazi: 作業ディレクトリ",
    },
  },
  opts = {
    -- netrwの代わりにyaziを使う
    open_for_directories = true,

    -- フローティングウィンドウ設定
    floating_window_scaling_factor = 0.9,
    yazi_floating_window_border = "rounded",
  },
}
