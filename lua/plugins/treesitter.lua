return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    -- よく使う言語のパーサーをインストール
    local languages = { 'lua', 'vim', 'vimdoc', 'python', 'javascript', 'typescript', 'go', 'ruby', 'markdown', 'bash', 'json', 'yaml' }

    -- パーサーがインストールされているか確認し、なければインストール
    for _, lang in ipairs(languages) do
      if not vim.treesitter.language.require_language(lang, nil, true) then
        vim.cmd('TSInstall ' .. lang)
      end
    end

    -- Markdown拡張子の登録
    vim.treesitter.language.register('markdown', 'md')
  end
}
