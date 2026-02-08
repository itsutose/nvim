-- Treesitter設定（Neovim 0.11対応）
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,  -- nvim-treesitterは遅延読み込み不可
  build = ':TSUpdate',
  config = function()
    -- 基本設定
    require'nvim-treesitter'.setup {
      install_dir = vim.fn.stdpath('data') .. '/site'
    }

    -- 必要なパーサーをインストール
    require'nvim-treesitter'.install {
      'python',
      'lua',
      'vim',
      'markdown',
      'bash',
      'json',
      'typescript',
      'javascript',
      'go',
      'ruby'
    }

    -- ファイルタイプごとにTreesitterハイライトを有効化
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'python',
        'lua',
        'vim',
        'markdown',
        'bash',
        'json',
        'typescript',
        'javascript',
        'go',
        'ruby'
      },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end
}
