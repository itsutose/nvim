-- netrwを完全無効化（永久削除しかできないため危険）
-- tree.luaのVeryLazy読み込みより前に実行する必要がある
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
vim.keymap.set('n', '<Space>', '<Nop>')

-- cursor shape + color by mode (lualineテーマの色を動的に取得)
vim.o.guicursor = 'n-c:block-CursorNormal,i-ci-ve:ver25-CursorInsert,v:block-CursorVisual,r-cr:hor20-CursorReplace,o:hor50'

-- lualineのハイライトグループからモード色を取得
local mode_colors = {}

local function get_lualine_mode_bg(mode_name)
  local hl = vim.api.nvim_get_hl(0, { name = "lualine_a_" .. mode_name, link = false })
  if hl and hl.bg then
    return string.format("#%06x", hl.bg)
  end
  return nil
end

vim.o.cursorline = true

local function sync_cursor_colors()
  mode_colors = {
    normal  = get_lualine_mode_bg("normal")  or "#89b4fa",
    insert  = get_lualine_mode_bg("insert")  or "#a6e3a1",
    visual  = get_lualine_mode_bg("visual")  or "#cba6f7",
    replace = get_lualine_mode_bg("replace") or "#f38ba8",
    command = get_lualine_mode_bg("command") or "#fab387",
  }
  vim.api.nvim_set_hl(0, "CursorNormal",  { bg = mode_colors.normal })
  vim.api.nvim_set_hl(0, "CursorInsert",  { bg = mode_colors.insert })
  vim.api.nvim_set_hl(0, "CursorVisual",  { bg = mode_colors.visual })
  vim.api.nvim_set_hl(0, "CursorReplace", { bg = mode_colors.replace })
end


-- timeout for key sequence
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

vim.o.relativenumber = false

-- 行頭←で前行末、行末→で次行頭に移動
vim.o.whichwrap = 'b,s,h,l,<,>,[,]'

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

-----------------------------------------
-- デフォルトカラースキーム
-----------------------------------------
-- Neovim起動完了後にカラースキームを適用
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local colorscheme_file = vim.fn.stdpath("data") .. "/default_colorscheme"
    local scheme = "catppuccin"
    local f = io.open(colorscheme_file, "r")
    if f then
      scheme = f:read("*l") or scheme
      f:close()
    end
    vim.cmd.colorscheme(scheme)
    -- プラグインのハイライト上書き後に透過・カーソル色を適用
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      sync_cursor_colors()
    end)
  end,
})

-----------------------------------------
-- 背景透過（Ghosttyのbackground-opacityを活かす）
-----------------------------------------
-- 手動でカラースキーム切替時にも透過を維持
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      sync_cursor_colors()
    end)
  end,
})
