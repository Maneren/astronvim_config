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
      dadbod_ui = true,
    },
  },
}
