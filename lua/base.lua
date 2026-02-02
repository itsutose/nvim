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
