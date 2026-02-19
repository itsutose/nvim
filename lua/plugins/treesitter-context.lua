return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "UIEnter" },
  config = function()
    require("treesitter-context").setup({
      -- mode = "topline",
    })
  end,
}
