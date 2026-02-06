return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- LSPキーマップの設定
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      end,
    })

    -- Neovim 0.11の新しいLSP設定方法
    -- LSPサーバーをインストールしている場合のみ有効化
    local lspconfig = require('lspconfig')

    -- Lua
    if vim.fn.executable('lua-language-server') == 1 then
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
    end

    -- TypeScript/JavaScript
    if vim.fn.executable('typescript-language-server') == 1 then
      lspconfig.ts_ls.setup({})
    end

    -- Go
    if vim.fn.executable('gopls') == 1 then
      lspconfig.gopls.setup({})
    end

    -- Ruby
    if vim.fn.executable('ruby-lsp') == 1 then
      lspconfig.ruby_lsp.setup({})
    end

    -- Python
    if vim.fn.executable('pyright') == 1 then
      lspconfig.pyright.setup({})
    end
  end
}
