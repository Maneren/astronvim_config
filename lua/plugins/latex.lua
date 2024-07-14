--- Extra features for LTeX LSP (dictionary, ignore, etc.)
--- https://github.com/barreiroleo/ltex-extra

---@type LazySpec
return {
  "barreiroleo/ltex-extra.nvim",
  ft = { "markdown", "tex" },
  dependencies = { "neovim/nvim-lspconfig" },
}
