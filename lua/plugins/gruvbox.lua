return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard", -- ハードコントラスト
      palette_overrides = {},
      overrides = {
        -- Pythonの関数呼び出しを強調
        ["@function.call"] = { fg = "#fabd2f", bold = true },
        -- 変数を強調
        ["@variable"] = { fg = "#83a598" },
        -- パラメータを強調
        ["@variable.parameter"] = { fg = "#d3869b" },
        -- クラスを強調
        ["@type"] = { fg = "#8ec07c", bold = true },
      },
    })
  end,
}
