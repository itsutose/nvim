return {
  "shellRaining/hlchunk.nvim",
  event = { "UIEnter" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        delay = 50,
        duration = 50,
      },
      indent = {
        enable = true,
      },
      line_num = {
        enable = false,
      },
      blank = {
        enable = false,
      },
    })
  end,
}
