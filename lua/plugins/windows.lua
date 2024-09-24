--- Window size auto-resizer
--- https://github.com/anuvyklack/windows.nvim

---@type LazySpec
return {
  "anuvyklack/windows.nvim",
  event = "User AstroFile",
  opts = {
    autowidth = {
      enable = true,
      winwidth = 5,
      filetype = {
        help = 2,
      },
    },
    ignore = {
      buftype = { "quickfix" },
      filetype = { "neo-tree" },
    },
    animation = {
      enable = true,
      duration = 200,
      fps = 60,
      easing = "in_out_sine",
    },
  },
}
