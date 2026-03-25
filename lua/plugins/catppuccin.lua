--- Colorscheme
--- https://github.com/catppuccin/nvim
--- extends astrocommunity

---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  ---@type CatppuccinOptions
  opts = {
    term_colors = true,
    transparent_background = not vim.g.neovide,
    float = {
      transparent = true,
    },
    lsp_styles = { inlay_hints = { background = false } },
  },
}
