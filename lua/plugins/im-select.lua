return {
  'keaising/im-select.nvim',
  config = function()
    require('im_select').setup({
      -- デフォルトの入力ソース（英語）
      default_im_select = 'com.apple.keylayout.ABC',

      -- macOSでim-selectコマンドのパス
      default_command = '/opt/homebrew/bin/im-select',

      -- インサートモード終了時に自動で英語に切り替え
      set_default_events = { 'InsertLeave', 'FocusLost' },
    })
  end
}
