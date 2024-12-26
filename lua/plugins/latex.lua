--- Extra features for LTeX LSP (dictionary, ignore, etc.)
--- https://github.com/barreiroleo/ltex-extra

---@type LazySpec
return {
  "barreiroleo/ltex-extra.nvim",
  branch = "dev",
  ft = { "markdown", "tex" },
  opts = {
    load_langs = {
      "en",
      "en-US",
    },
    log_level = "warn",
    path = vim.fn.expand("~") .. "/.config/ltex",
  },
}
