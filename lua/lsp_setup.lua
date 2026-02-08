-- LSP設定（init.luaから直接読み込まれる）

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

    -- LSPセマンティックハイライトを無効化（Treesitterのみ使用）
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then
      -- セマンティックトークンを無効化
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Python
if vim.fn.executable('pyright-langserver') == 1 then
  vim.api.nvim_create_autocmd({'FileType', 'BufReadPost'}, {
    pattern = {'python', '*.py'},
    callback = function()
      if vim.bo.filetype == 'python' then
        local clients = vim.lsp.get_clients({ bufnr = 0, name = 'pyright' })
        if #clients == 0 then
          local root_files = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' }
          local root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]) or vim.fn.getcwd()

          vim.lsp.start({
            name = 'pyright',
            cmd = { 'pyright-langserver', '--stdio' },
            root_dir = root_dir,
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  diagnosticMode = "workspace",
                  useLibraryCodeForTypes = true,
                  typeCheckingMode = "basic",
                }
              }
            },
          })
          vim.notify('Pyright started', vim.log.levels.INFO)
        end
      end
    end,
  })
end

-- Lua
if vim.fn.executable('lua-language-server') == 1 then
  vim.api.nvim_create_autocmd({'FileType', 'BufReadPost'}, {
    pattern = {'lua', '*.lua'},
    callback = function()
      if vim.bo.filetype == 'lua' then
        local clients = vim.lsp.get_clients({ bufnr = 0, name = 'lua_ls' })
        if #clients == 0 then
          local root_files = { '.luarc.json', '.git' }
          local root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]) or vim.fn.getcwd()
          vim.lsp.start({
            name = 'lua_ls',
            cmd = { 'lua-language-server' },
            root_dir = root_dir,
            settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
          })
        end
      end
    end,
  })
end
