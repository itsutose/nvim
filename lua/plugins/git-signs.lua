return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- ファイルを開いたときに読み込み
  config = function()
    require('gitsigns').setup({
      signs = {
        -- 行番号横に表示されるマーク
        add          = { text = '│' }, -- 追加された行
        change       = { text = '│' }, -- 変更された行
        delete       = { text = '_' }, -- 削除された行
        topdelete    = { text = '‾' }, -- ファイル先頭で削除
        changedelete = { text = '~' }, -- 変更と削除が混在
        untracked    = { text = '┆' }, -- 未追跡ファイル
      },

      -- カーソル行のblameを自動表示
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500, -- 0.5秒後に表示
      },

      -- キーマップ設定
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- ナビゲーション（変更箇所間の移動）
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = '次の変更箇所へ' })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = '前の変更箇所へ' })

        -- アクション
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'Gitステージング（現在行）' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Git変更を元に戻す（現在行）' })
        map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Gitステージング（選択範囲）' })
        map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Git変更を元に戻す（選択範囲）' })

        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Gitステージング（ファイル全体）' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Gitアンステージング' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Git変更を元に戻す（ファイル全体）' })

        map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git変更をプレビュー' })
        map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = 'Git blame表示' })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Git blameの自動表示切り替え' })

        map('n', '<leader>hd', gs.diffthis, { desc = 'Git差分表示' })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Git差分表示（HEAD比較）' })

        -- テキストオブジェクト（変更箇所を選択）
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Git変更箇所を選択' })
      end
    })
  end
}
