return {
  'akinsho/toggleterm.nvim',
  version = "*",
  event = 'VeryLazy',
  config = function()
    require('toggleterm').setup({
      -- ターミナルのサイズ
      size = function(term)
        if term.direction == "horizontal" then
          return 15  -- 水平分割時の高さ
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4  -- 垂直分割時の幅（40%）
        end
      end,

      -- 開く方向（デフォルト）
      direction = 'float',  -- 'float' | 'horizontal' | 'vertical' | 'tab'

      -- フローティングウィンドウの設定
      float_opts = {
        border = 'curved',  -- 'single' | 'double' | 'shadow' | 'curved' | ...
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        winblend = 0,  -- 透明度 0-100
      },

      -- ターミナルを開いたときの挙動
      open_mapping = [[<c-\>]],  -- Ctrl+\ でトグル
      hide_numbers = true,        -- 行番号を非表示
      shade_terminals = true,     -- ターミナルを少し暗くする
      shading_factor = 2,
      start_in_insert = true,     -- ターミナルを開いたらInsert modeに
      insert_mappings = true,     -- Insert modeでもopen_mappingを有効に
      terminal_mappings = true,   -- Terminal modeでもopen_mappingを有効に
      persist_size = true,
      persist_mode = true,

      -- シェル設定
      shell = vim.o.shell,

      -- 自動でディレクトリを変更
      auto_scroll = true,
    })

    -- キーマップ設定
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Ctrl+\ でフローティングターミナルをトグル（既に設定済み）
    -- map('n', '<C-\\>', '<cmd>ToggleTerm direction=float<cr>', { noremap = true, silent = true, desc = 'Toggle floating terminal' })
    -- map('t', '<C-\\>', '<cmd>ToggleTerm<cr>', { noremap = true, silent = true, desc = 'Toggle terminal' })

    -- 水平分割ターミナル
    map('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', { noremap = true, silent = true, desc = '水平ターミナル' })

    -- 垂直分割ターミナル
    map('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', { noremap = true, silent = true, desc = '垂直ターミナル' })

    -- Terminal mode内での移動（Esc でNormal modeに）
    map('t', '<Esc>', [[<C-\><C-n>]], opts)
    map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

    -- Terminal mode内でさらに分割（Normal modeと同じキーだが動作が異なる）
    -- ターミナル内で垂直分割して新しいターミナルを開く
    map('t', '<leader>tv', [[<C-\><C-n>:vsp | terminal<CR>i]], opts)

    -- ターミナル内で水平分割して新しいターミナルを開く
    map('t', '<leader>th', [[<C-\><C-n>:sp | terminal<CR>i]], opts)
  end,
}
