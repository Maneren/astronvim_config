--- Colorscheme
--- https://github.com/catppuccin/nvim
--- extends astrocommunity

---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  ---@type CatppuccinOptions
  opts = {
    term_colors = true,
    integrations = {
      indent_blankline = { enabled = true },
      dadbod_ui = true,
    },
  },
}
