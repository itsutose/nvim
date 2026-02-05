return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()

    -- Cmd+/ でコメントトグル（GhosttyでF13に変換して送信）
    -- tmux内外で両方動作するように、両方のキーコードをマッピング

    -- tmux外: F13 (\x1b[25~) → <F13>として認識される
    vim.keymap.set('n', '<F13>', 'gcc', { remap = true, desc = 'コメントトグル (Cmd+/)' })
    vim.keymap.set('i', '<F13>', '<Esc>gcci', { remap = true, desc = 'コメントトグル (Cmd+/)' })
    vim.keymap.set('v', '<F13>', function()
      local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
      vim.api.nvim_feedkeys(esc, 'nx', false)
      require('Comment.api').toggle.linewise(vim.fn.visualmode())
    end, { desc = 'コメントトグル (Cmd+/)' })

    -- tmux内: F13 → \x1b[1;2R → Neovimが<S-F3>として解釈
    vim.keymap.set('n', '<S-F3>', 'gcc', { remap = true, desc = 'コメントトグル (Cmd+/ via tmux)' })
    vim.keymap.set('i', '<S-F3>', '<Esc>gcci', { remap = true, desc = 'コメントトグル (Cmd+/ via tmux)' })
    vim.keymap.set('v', '<S-F3>', function()
      local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
      vim.api.nvim_feedkeys(esc, 'nx', false)
      require('Comment.api').toggle.linewise(vim.fn.visualmode())
    end, { desc = 'コメントトグル (Cmd+/ via tmux)' })
  end
}
