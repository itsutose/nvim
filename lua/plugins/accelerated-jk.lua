-- ============================================================================
-- accelerated-jk - jk連打で加速移動
-- ============================================================================
-- jまたはkを連打すると徐々に移動速度が上がる
-- 長距離の垂直移動が快適に

return {
  "rainbowhxch/accelerated-jk.nvim",
  event = "VeryLazy",
  config = function()
    require('accelerated-jk').setup({
      -- 加速カーブの設定
      mode = 'time_driven',  -- time_driven または position_driven
      enable_deceleration = false,  -- 減速を無効化
      acceleration_motions = {},  -- 空の場合はデフォルト（j, k）
      acceleration_limit = 150,  -- 最大加速度
      acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },  -- 連打回数に応じた移動量
      -- 1回目: 7行, 2回目: 12行, 3回目: 17行...と加速
    })
  end,
  keys = {
    { "j", "<Plug>(accelerated_jk_gj)", mode = "n", desc = "Accelerated j" },
    { "k", "<Plug>(accelerated_jk_gk)", mode = "n", desc = "Accelerated k" },
  },
}
