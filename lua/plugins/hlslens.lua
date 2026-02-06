return {
  'kevinhwang91/nvim-hlslens',
  event = 'VeryLazy',
  config = function()
    require('hlslens').setup({
      -- 検索結果の表示位置
      calm_down = true,

      -- 検索結果の表示（例: [3/10] のように表示）
      nearest_only = false,

      -- 自動的にnormalモードでの検索コマンドを拡張
      override_lens = function(render, posList, nearest, idx, relIdx)
        local sfw = vim.v.searchforward == 1
        local indicator, text, chunks
        local absRelIdx = math.abs(relIdx)

        if absRelIdx > 1 then
          indicator = string.format('%d%s', absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
        elseif absRelIdx == 1 then
          indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
        else
          indicator = ''
        end

        local lnum, col = unpack(posList[idx])
        if nearest then
          local cnt = #posList
          if indicator ~= '' then
            text = string.format('[%s %d/%d]', indicator, idx, cnt)
          else
            text = string.format('[%d/%d]', idx, cnt)
          end
          chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
        else
          text = string.format('[%s %d]', indicator, idx)
          chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
        end
        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
      end,
    })

    -- スマート検索との統合
    -- n/N でhlslensを使うように設定
    local kopts = {noremap = true, silent = true}
    vim.api.nvim_set_keymap('n', 'n',
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.api.nvim_set_keymap('n', 'N',
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.api.nvim_set_keymap('n', '*',
      [[*<Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.api.nvim_set_keymap('n', '#',
      [[#<Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.api.nvim_set_keymap('n', 'g*',
      [[g*<Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.api.nvim_set_keymap('n', 'g#',
      [[g#<Cmd>lua require('hlslens').start()<CR>]],
      kopts)
  end,
}
