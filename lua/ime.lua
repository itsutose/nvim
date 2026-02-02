-- ============================================================================
-- IME強制英語化 - Normal/Visualモードで確実に英語にする
-- ============================================================================
-- モード変更時にのみチェック（定期チェックなし、効率的）

local im_select_path = '/opt/homebrew/bin/im-select'
local default_im = 'com.apple.keylayout.ABC'

-- Nvimのモードが変わった時に、Normal/Visual/Commandモードなら英語化
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    -- Insert mode (i, ic, ix, R, Rc, Rx) 以外なら英語化
    if not mode:match('^[iR]') then
      vim.fn.system(im_select_path .. ' ' .. default_im)
    end
  end,
})

-- 起動時とフォーカス取得時も英語化
vim.api.nvim_create_autocmd({
  'VimEnter',      -- Nvim起動時
  'FocusGained',   -- フォーカス取得時
}, {
  pattern = '*',
  callback = function()
    vim.fn.system(im_select_path .. ' ' .. default_im)
  end,
})
