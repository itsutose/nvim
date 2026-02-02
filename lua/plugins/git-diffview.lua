-- ============================================================================
-- diffview.nvim - Git差分表示に特化したプラグイン
-- ============================================================================
-- 複数ファイルの差分を並べて表示したり、コミット履歴を視覚的に確認できる
-- マージコンフリクトの解決も快適に行える

return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  keys = {
    -- 差分を開く/閉じる
    { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Diffview: 差分を開く" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview: 差分を閉じる" },

    -- ファイル履歴
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: リポジトリ履歴" },
    { "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: ファイル履歴" },

    -- ビジュアルモードで選択範囲の履歴
    { "<leader>dv", ":'<,'>DiffviewFileHistory<cr>", mode = "v", desc = "Diffview: 選択範囲の履歴" },
  },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      -- 差分表示の設定
      diff_binaries = false,    -- バイナリファイルは差分表示しない
      enhanced_diff_hl = true,  -- 差分のハイライトを強化

      -- Git設定
      git_cmd = { "git" },
      use_icons = true,

      -- アイコン設定
      icons = {
        folder_closed = "",
        folder_open = "",
      },

      -- サインカラム設定
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },

      -- ファイルパネルの設定
      file_panel = {
        listing_style = "tree",  -- tree | list
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
        },
      },

      -- ファイル履歴パネルの設定
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
        },
      },

      -- コミットログの設定
      commit_log_panel = {
        win_config = {
          position = "bottom",
          height = 16,
        },
      },

      -- キーマップ設定
      keymaps = {
        disable_defaults = false,
        view = {
          -- 差分ビュー内でのキーマップ
          { "n", "<tab>",      actions.select_next_entry,         { desc = "次のファイルへ" } },
          { "n", "<s-tab>",    actions.select_prev_entry,         { desc = "前のファイルへ" } },
          { "n", "gf",         actions.goto_file,                 { desc = "ファイルを開く" } },
          { "n", "<C-w><C-f>", actions.goto_file_split,           { desc = "ファイルを分割で開く" } },
          { "n", "<C-w>gf",    actions.goto_file_tab,             { desc = "ファイルを新規タブで開く" } },
          { "n", "<leader>e",  actions.focus_files,               { desc = "ファイルパネルにフォーカス" } },
          { "n", "<leader>b",  actions.toggle_files,              { desc = "ファイルパネル表示切替" } },
          { "n", "g<C-x>",     actions.cycle_layout,              { desc = "レイアウト切替" } },
          { "n", "[x",         actions.prev_conflict,             { desc = "前のコンフリクトへ" } },
          { "n", "]x",         actions.next_conflict,             { desc = "次のコンフリクトへ" } },
          { "n", "<leader>co", actions.conflict_choose("ours"),   { desc = "自分の変更を採用" } },
          { "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "相手の変更を採用" } },
          { "n", "<leader>cb", actions.conflict_choose("base"),   { desc = "ベースを採用" } },
          { "n", "<leader>ca", actions.conflict_choose("all"),    { desc = "両方を採用" } },
          { "n", "dx",         actions.conflict_choose("none"),   { desc = "すべて削除" } },
        },
        file_panel = {
          -- ファイルパネル内でのキーマップ
          { "n", "j",             actions.next_entry,           { desc = "次のエントリ" } },
          { "n", "<down>",        actions.next_entry,           { desc = "次のエントリ" } },
          { "n", "k",             actions.prev_entry,           { desc = "前のエントリ" } },
          { "n", "<up>",          actions.prev_entry,           { desc = "前のエントリ" } },
          { "n", "<cr>",          actions.select_entry,         { desc = "ファイルを選択" } },
          { "n", "o",             actions.select_entry,         { desc = "ファイルを選択" } },
          { "n", "<2-LeftMouse>", actions.select_entry,         { desc = "ファイルを選択" } },
          { "n", "-",             actions.toggle_stage_entry,   { desc = "ステージング切替" } },
          { "n", "S",             actions.stage_all,            { desc = "全てステージング" } },
          { "n", "U",             actions.unstage_all,          { desc = "全てアンステージング" } },
          { "n", "X",             actions.restore_entry,        { desc = "変更を破棄" } },
          { "n", "R",             actions.refresh_files,        { desc = "ファイル一覧を更新" } },
          { "n", "L",             actions.open_commit_log,      { desc = "コミットログを開く" } },
          { "n", "<c-b>",         actions.scroll_view(-0.25),   { desc = "スクロールアップ" } },
          { "n", "<c-f>",         actions.scroll_view(0.25),    { desc = "スクロールダウン" } },
          { "n", "<tab>",         actions.select_next_entry,    { desc = "次のファイルへ" } },
          { "n", "<s-tab>",       actions.select_prev_entry,    { desc = "前のファイルへ" } },
          { "n", "gf",            actions.goto_file,            { desc = "ファイルを開く" } },
          { "n", "<C-w><C-f>",    actions.goto_file_split,      { desc = "ファイルを分割で開く" } },
          { "n", "<C-w>gf",       actions.goto_file_tab,        { desc = "ファイルを新規タブで開く" } },
          { "n", "i",             actions.listing_style,        { desc = "リスト表示切替" } },
          { "n", "f",             actions.toggle_flatten_dirs,  { desc = "ディレクトリ表示切替" } },
          { "n", "<leader>e",     actions.focus_files,          { desc = "ファイルパネルにフォーカス" } },
          { "n", "<leader>b",     actions.toggle_files,         { desc = "ファイルパネル表示切替" } },
          { "n", "g<C-x>",        actions.cycle_layout,         { desc = "レイアウト切替" } },
          { "n", "[x",            actions.prev_conflict,        { desc = "前のコンフリクトへ" } },
          { "n", "]x",            actions.next_conflict,        { desc = "次のコンフリクトへ" } },
        },
        file_history_panel = {
          -- ファイル履歴パネル内でのキーマップ
          { "n", "g!",            actions.options,              { desc = "オプション表示" } },
          { "n", "<C-A-d>",       actions.open_in_diffview,     { desc = "Diffviewで開く" } },
          { "n", "y",             actions.copy_hash,            { desc = "コミットハッシュをコピー" } },
          { "n", "L",             actions.open_commit_log,      { desc = "コミットログを開く" } },
          { "n", "zR",            actions.open_all_folds,       { desc = "全て展開" } },
          { "n", "zM",            actions.close_all_folds,      { desc = "全て折りたたむ" } },
          { "n", "j",             actions.next_entry,           { desc = "次のエントリ" } },
          { "n", "<down>",        actions.next_entry,           { desc = "次のエントリ" } },
          { "n", "k",             actions.prev_entry,           { desc = "前のエントリ" } },
          { "n", "<up>",          actions.prev_entry,           { desc = "前のエントリ" } },
          { "n", "<cr>",          actions.select_entry,         { desc = "エントリを選択" } },
          { "n", "o",             actions.select_entry,         { desc = "エントリを選択" } },
          { "n", "<2-LeftMouse>", actions.select_entry,         { desc = "エントリを選択" } },
          { "n", "<c-b>",         actions.scroll_view(-0.25),   { desc = "スクロールアップ" } },
          { "n", "<c-f>",         actions.scroll_view(0.25),    { desc = "スクロールダウン" } },
          { "n", "<tab>",         actions.select_next_entry,    { desc = "次のエントリ" } },
          { "n", "<s-tab>",       actions.select_prev_entry,    { desc = "前のエントリ" } },
          { "n", "gf",            actions.goto_file,            { desc = "ファイルを開く" } },
          { "n", "<C-w><C-f>",    actions.goto_file_split,      { desc = "ファイルを分割で開く" } },
          { "n", "<C-w>gf",       actions.goto_file_tab,        { desc = "ファイルを新規タブで開く" } },
          { "n", "<leader>e",     actions.focus_files,          { desc = "ファイルパネルにフォーカス" } },
          { "n", "<leader>b",     actions.toggle_files,         { desc = "ファイルパネル表示切替" } },
          { "n", "g<C-x>",        actions.cycle_layout,         { desc = "レイアウト切替" } },
        },
        option_panel = {
          { "n", "<tab>", actions.select_entry,         { desc = "エントリを選択" } },
          { "n", "q",     actions.close,                { desc = "閉じる" } },
        },
      },
    })
  end,
}
