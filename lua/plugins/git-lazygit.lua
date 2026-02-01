return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    -- Space + gg でlazygitを開く
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit: 開く" },
    -- Space + gf でカレントファイルの履歴を開く
    { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit: ファイル履歴" },
  },
  config = function()
    -- lazygitの設定
    vim.g.lazygit_floating_window_winblend = 0 -- 透明度（0=不透明）
    vim.g.lazygit_floating_window_scaling_factor = 0.9 -- ウィンドウサイズ（0.9=画面の90%）
    vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'} -- 枠線の文字
    vim.g.lazygit_floating_window_use_plenary = 1 -- plenaryを使用
    vim.g.lazygit_use_neovim_remote = 1 -- Neovimとの連携を有効化

    -- lazygit起動時に自動でターミナルモードに入る
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "lazygit",
      callback = function()
        vim.cmd("startinsert")
      end,
    })

    -- ターミナルモードでEscキーでノーマルモードに戻る設定を無効化
    -- （lazygit内でEscを使うため）
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*lazygit*",
      callback = function()
        vim.keymap.set('t', '<Esc>', '<Esc>', { buffer = true, nowait = true })
      end,
    })
  end
}
