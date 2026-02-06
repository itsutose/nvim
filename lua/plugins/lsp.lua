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

    -- Neovim 0.11の新しいLSP設定方法（vim.lsp.config使用）
    -- LSPサーバーをインストールしている場合のみ有効化

    -- Lua
    if vim.fn.executable('lua-language-server') == 1 then
      vim.lsp.config('lua_ls', {
        cmd = { 'lua-language-server' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
      vim.lsp.enable('lua_ls')
    end

    -- TypeScript/JavaScript
    if vim.fn.executable('typescript-language-server') == 1 then
      vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
      })
      vim.lsp.enable('ts_ls')
    end

    -- Go
    if vim.fn.executable('gopls') == 1 then
      vim.lsp.config('gopls', {
        cmd = { 'gopls' },
        root_markers = { 'go.mod', 'go.work', '.git' },
      })
      vim.lsp.enable('gopls')
    end

    -- Ruby
    if vim.fn.executable('ruby-lsp') == 1 then
      vim.lsp.config('ruby_lsp', {
        cmd = { 'ruby-lsp' },
        root_markers = { 'Gemfile', '.git' },
      })
      vim.lsp.enable('ruby_lsp')
    end

    -- Python
    if vim.fn.executable('pyright') == 1 then
      vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
      })
      vim.lsp.enable('pyright')
    end
  end
}
