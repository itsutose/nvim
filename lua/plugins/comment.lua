return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()

    -- Cmd+/ でコメントトグル（Ghosttyで ^_ に変換して送信）
    local key_0x1f = string.char(0x1f)
    vim.keymap.set('n', key_0x1f, 'gcc', { remap = true, desc = 'コメントトグル (Cmd+/)' })
    vim.keymap.set('i', key_0x1f, '<Esc>gcci', { remap = true, desc = 'コメントトグル (Cmd+/)' })
    vim.keymap.set('v', key_0x1f, 'gc', { remap = true, desc = 'コメントトグル (Cmd+/)' })
  end
}
