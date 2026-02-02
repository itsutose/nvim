-- ============================================================================
-- Auto Save - 自動保存設定
-- ============================================================================
-- VSCodeのような自動保存機能
-- カーソル停止から指定時間後に自動保存

-- カーソル停止からの待機時間（ミリ秒）
vim.o.updatetime = 1000  -- 1秒（デフォルト: 4000ms）

-- Undo履歴をファイルに保存（Nvim終了後も保持）
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("data") .. "/undo"

-- Undo履歴の最大数
vim.o.undolevels = 10000  -- デフォルト: 1000

-- 自動保存の設定
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
  pattern = "*",
  callback = function()
    -- 変更があり、ファイル名がある場合のみ保存
    if vim.bo.modified and vim.fn.expand("%") ~= "" then
      -- 保存できないファイルタイプは除外
      local excluded_filetypes = {
        "lazy",
        "TelescopePrompt",
        "NvimTree",
        "help",
      }

      if not vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
        vim.cmd("silent! write")
        -- print("Auto-saved: " .. vim.fn.expand("%:t"))  -- 保存メッセージ（不要ならコメントアウト）
      end
    end
  end,
})

-- InsertLeave（Normalモードに戻る時）でも保存
-- CursorHoldと併用することで、より確実に保存される
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.fn.expand("%") ~= "" then
      local excluded_filetypes = {
        "lazy",
        "TelescopePrompt",
        "NvimTree",
        "help",
      }

      if not vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
        vim.cmd("silent! write")
      end
    end
  end,
})

-- BufLeave（バッファを離れる時）でも保存
-- 別のファイルに切り替える前に確実に保存する
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.fn.expand("%") ~= "" then
      local excluded_filetypes = {
        "lazy",
        "TelescopePrompt",
        "NvimTree",
        "help",
      }

      if not vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
        vim.cmd("silent! write")
      end
    end
  end,
})
