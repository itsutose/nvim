-- IME自動切り替え設定
if vim.fn.executable('im-select') == 1 then
  local im_select_path = vim.fn.exepath('im-select')
  local default_im = 'com.apple.keylayout.ABC'  -- 英語入力のID

  -- Insert modeから抜ける時に英語入力に戻す
  vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*',
    callback = function()
      vim.fn.system(im_select_path .. ' ' .. default_im)
    end,
  })
end
