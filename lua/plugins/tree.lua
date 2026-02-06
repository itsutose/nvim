-- ============================================================================
-- nvim-tree - ファイルエクスプローラー
-- ============================================================================
-- 変更の効果まとめ:
-- | 項目                   | 変更前     | 変更後         | 効果                 |
-- |------------------------|-----------|---------------|---------------------|
-- | コマンドライン高さ      | 1行       | 2行           | 長いメッセージが収まる |
-- | ENTER待ち              | 頻繁に発生 | ほぼ無くなる   | ストレス軽減         |
-- | 編集エリア             | 広い      | 1行分狭くなる  | 許容範囲            |
-- | NvimTree確認           | 詳細表示   | 簡略化        | サクサク操作可能     |
--
-- Note: base.luaで vim.o.cmdheight = 2 を設定済み

return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  dependencies = {"nvim-tree/nvim-web-devicons"},
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "TreeToggle" },
  },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      -- 通知メッセージを簡潔に
      ui = {
        confirm = {
          remove = false,  -- 削除確認を簡略化
          trash = false,   -- ゴミ箱確認を簡略化
        },
      },
      -- ファイル操作後の動作
      actions = {
        open_file = {
          resize_window = false,  -- ウィンドウサイズを変更しない
        },
      },
      -- キーマップ設定
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- デフォルトのキーマップを使用
        api.config.mappings.default_on_attach(bufnr)

        -- cd: ディレクトリをルートとして設定（そのディレクトリに移動）
        vim.keymap.set('n', 'cd', api.tree.change_root_to_node, opts('CD'))

        -- Enter / o: ディレクトリを開く/閉じる、ファイルを開く
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))

        -- u: 親ディレクトリに戻る（cd upの意味）
        vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))

        -- -: 親ディレクトリに戻る（代替キー）
        vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
      end,
    })
  end
}
