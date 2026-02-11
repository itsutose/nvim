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
  lazy = false,  -- 起動時に即座に読み込む（netrwの代替として常に必要）
  dependencies = {"nvim-tree/nvim-web-devicons"},
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "TreeToggle" },
  },
  config = function()
    -- netrw無効化はbase.luaの先頭で実施済み（VeryLazyより前に必要）

    -- 起動時にnvim-treeを自動で開く
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        -- ディレクトリを開いた場合
        local is_directory = vim.fn.isdirectory(data.file) == 1
        -- 引数なしで起動した場合
        local no_args = data.file == ""

        if is_directory or no_args then
          if is_directory then
            vim.cmd.cd(data.file)
          end
          require("nvim-tree.api").tree.open()
        end
      end,
    })

    require("nvim-tree").setup({
      -- ファイルを開いた時にツリーをその場所に追従させる
      update_focused_file = {
        enable = true,
        update_root = true,  -- ツリーのrootも追従して変更する
      },
      -- 削除時はゴミ箱に移動（復元可能）
      trash = {
        cmd = "trash",  -- macOSのtrashコマンド
      },
      -- 確認ダイアログを有効化（安全のため）
      ui = {
        confirm = {
          remove = true,   -- 削除確認を表示
          trash = true,    -- ゴミ箱移動確認を表示
          default_yes = false,  -- デフォルトはNo（安全側）
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

        -- =====================================================
        -- 安全化: 永久削除(rm -rf)を全て無効化し、trashに統一
        -- =====================================================
        -- プレビュー中のバッファを先に閉じてからtrashする（window id無効エラー回避）
        local function safe_trash()
          local node = api.tree.get_node_under_cursor()
          if node and node.absolute_path then
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              if vim.api.nvim_win_is_valid(win) then
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.api.nvim_buf_get_name(buf) == node.absolute_path then
                  pcall(vim.api.nvim_buf_delete, buf, { force = true })
                  break
                end
              end
            end
          end
          api.fs.trash()
        end

        -- d: デフォルトはapi.fs.remove(永久削除) → trashに差し替え
        vim.keymap.set('n', 'd', safe_trash, opts('Trash'))
        -- D: 元からtrashなのでそのまま（明示的に再設定）
        vim.keymap.set('n', 'D', safe_trash, opts('Trash'))
        -- <Del>: デフォルトはapi.fs.remove(永久削除) → 無効化
        vim.keymap.set('n', '<Del>', '', opts('(disabled)'))
        -- bd: デフォルトはapi.marks.bulk.delete(一括永久削除) → bulk.trashに差し替え
        vim.keymap.set('n', 'bd', api.marks.bulk.trash, opts('Trash Bookmarked'))

        -- .: ディレクトリをルートとして設定（neo-treeと統一）
        vim.keymap.set('n', '.', api.tree.change_root_to_node, opts('Set Root'))

        -- Enter / o: ディレクトリを開く/閉じる、ファイルを開く
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))

        -- u: 親ディレクトリに戻る（cd upの意味）
        vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))

        -- -: 親ディレクトリに戻る（代替キー）
        vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))

        -- カーソル移動時に自動プレビュー
        local last_preview_path = nil
        vim.api.nvim_create_autocmd('CursorMoved', {
          buffer = bufnr,
          callback = function()
            -- カーソル下のノードを取得
            local node = api.tree.get_node_under_cursor()
            if node and node.type == 'file' then
              -- 同じファイルなら何もしない（パフォーマンス向上）
              if node.absolute_path == last_preview_path then
                return
              end
              last_preview_path = node.absolute_path

              -- プレビューを開く
              api.node.open.preview()

              -- プレビューウィンドウでfiletypeを設定してハイライトを有効化
              vim.defer_fn(function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  local buf = vim.api.nvim_win_get_buf(win)
                  local bufname = vim.api.nvim_buf_get_name(buf)
                  if bufname == node.absolute_path then
                    -- ファイルタイプを検出して設定
                    local ft = vim.filetype.match({ filename = node.absolute_path })
                    if ft then
                      vim.api.nvim_buf_set_option(buf, 'filetype', ft)
                    end
                    break
                  end
                end
              end, 50)
            else
              last_preview_path = nil
            end
          end,
        })
      end,
    })
  end
}
