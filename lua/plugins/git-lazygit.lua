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
    -- Space + gr でlazygitを再起動（フリーズ時の回避策）
    {
      "<leader>gr",
      function()
        -- lazygitウィンドウを閉じる
        vim.cmd('close')
        -- 少し待ってから再度開く
        vim.defer_fn(function()
          vim.cmd('LazyGit')
        end, 100)
      end,
      desc = "LazyGit: 再起動"
    },
  },
  config = function()
    -- lazygitの設定
    vim.g.lazygit_floating_window_winblend = 0 -- 透明度（0=不透明）
    vim.g.lazygit_floating_window_scaling_factor = 0.9 -- ウィンドウサイズ（0.9=画面の90%）
    vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'} -- 枠線の文字
    vim.g.lazygit_floating_window_use_plenary = 1 -- plenaryを使用
    vim.g.lazygit_use_neovim_remote = 1 -- Neovimとの連携を有効化

    -- lazygit起動時に確実にターミナルモードに入る
    -- 複数のイベントで対処（フォーカス問題の根本的解決）
    vim.api.nvim_create_autocmd({"FileType", "TermOpen", "BufEnter"}, {
      pattern = "*lazygit*",
      callback = function()
        -- lazygitバッファの場合のみ
        if vim.bo.filetype == "lazygit" or vim.api.nvim_buf_get_name(0):match("lazygit") then
          -- 少し遅延させて確実にターミナルモードに入る
          vim.schedule(function()
            if vim.api.nvim_get_mode().mode ~= "t" then
              vim.cmd("startinsert")
            end
          end)
        end
      end,
    })

    -- ターミナルモードでEscキーでノーマルモードに戻る設定を無効化
    -- （lazygit内でEscを使うため）
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*lazygit*",
      callback = function()
        vim.keymap.set('t', '<Esc>', '<Esc>', { buffer = true, nowait = true })
        -- Ctrl-r でlazygitを再起動（UIフリーズ時の対処）
        vim.keymap.set('t', '<C-r>', function()
          -- lazygitウィンドウを閉じる
          vim.cmd('close')
          -- 少し待ってから再度開く
          vim.defer_fn(function()
            vim.cmd('LazyGit')
          end, 100)
        end, { buffer = true, desc = "LazyGit: 再起動" })
      end,
    })
  end
}
