return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          {
            'filename',
            path = 1,  -- 0: ファイル名のみ, 1: 相対パス, 2: 絶対パス, 3: 絶対パス+~省略
            shorting_target = 40,  -- 短縮後の最大文字数
            symbols = {
              modified = ' [+]',
              readonly = ' []',
              unnamed = '[No Name]',
            }
          }
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1,  -- 0: ファイル名のみ, 1: 相対パス, 2: 絶対パス, 3: 絶対パス+~省略
            shorting_target = 40,  -- 短縮後の最大文字数
            symbols = {
              modified = ' [+]',
              readonly = ' []',
              unnamed = '[No Name]',
            }
          }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
    })
  end
}
