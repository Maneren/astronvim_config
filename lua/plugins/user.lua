---@type LazySpec
return {
  { "max397574/better-escape.nvim", enabled = false },
  {
    -- TODO: use fork until https://github.com/nvimtools/none-ls.nvim/issues/226 is
    -- resolved
    "nvimtools/none-ls.nvim",
    url = "https://github.com/Maneren/none-ls.nvim",
    branch = "unicode-length",
    commit = false,
  },
  { "AstroNvim/astrocore", version = false, branch = "v2" },
  { "AstroNvim/astrolsp", version = false, branch = "v3" },
  { "AstroNvim/astroui", version = false, branch = "v3" },
}
