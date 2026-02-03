vim.o.encoding = 'utf-8'
vim.o.number = true

vim.o.smartindent = true
vim.o.clipboard = "unnamedplus"
vim.o.list = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.wildmenu = true
vim.o.ruler = true
vim.o.smartcase = true
vim.o.showmatch = true

vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- cursor shape by mode
vim.o.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50'

-- timeout for key sequence
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

vim.o.relativenumber = true

-- コマンドライン高さ（メッセージがENTER待ちにならないように）
vim.o.cmdheight = 2

-- メッセージ表示をコンパクトに
vim.opt.shortmess:append("c")  -- 補完メッセージを短縮
vim.opt.shortmess:append("I")  -- 起動メッセージを非表示


-----------------------------------------
-- 外部変更の自動検知・自動読み込み
-----------------------------------------
vim.o.autoread = true  -- 外部で変更されたファイルを自動で読み込む

-- 方法1: イベントベースの検知（重要なタイミング）
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "InsertLeave"}, {
  pattern = "*",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("silent! checktime")
    end
  end,
})

-- 方法2: タイマーベースの検知（常時監視）
-- Normal mode, Visual mode で常に外部変更を検知
-- CPU使用率: 約0.02%（無視できるレベル）
-- メモリ影響: ほぼゼロ
-- グローバル変数にしてGCを防ぐ
_G.external_change_check_timer = vim.loop.new_timer()
_G.external_change_check_timer:start(0, 300, vim.schedule_wrap(function()  -- 300ms = 0.3秒ごと
  local mode = vim.api.nvim_get_mode().mode
  -- Insert mode (i, ic, ix, R, Rc, Rx) 以外でチェック
  if not mode:match('^[iR]') and vim.fn.getcmdwintype() == "" then
    vim.cmd("silent! checktime")
  end
end))

-- 外部変更が検知された時に通知（非同期で実行、CPU負荷を軽減）
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      -- ファイル名を含めた通知
      local filename = vim.fn.expand("%:t")
      vim.notify(
        string.format("'%s' changed externally. Reloaded.", filename),
        vim.log.levels.INFO,
        { timeout = 2000 }  -- 2秒で自動消去
      )
    end)
  end,
})
