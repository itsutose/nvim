return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()

    -- Cmd+/ でコメントトグル（GhosttyでF13に変換して送信）
    vim.keymap.set('n', '<F13>', 'gcc', { remap = true, desc = 'コメントトグル (Cmd+/)' })
    vim.keymap.set('i', '<F13>', '<Esc>gcci', { remap = true, desc = 'コメントトグル (Cmd+/)' })

    -- Visual modeでは常に行コメント（ブロックコメントにならない）
    vim.keymap.set('v', '<F13>', function()
      -- ESCで選択解除してからlinewiseコメントを適用
      local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
      vim.api.nvim_feedkeys(esc, 'nx', false)
      require('Comment.api').toggle.linewise(vim.fn.visualmode())
    end, { desc = 'コメントトグル (Cmd+/)' })
  end
}
