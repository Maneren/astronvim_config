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
    transparent_background = not vim.g.neovide,
    float = {
      transparent = true,
    },
  },
}
