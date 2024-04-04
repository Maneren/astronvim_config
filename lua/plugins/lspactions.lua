return {
  "RishabhRD/lspactions",
  lazy = false,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-lua/popup.nvim" },
  },
  config = function()
    local lspactions = require("lspactions")

    vim.ui.select = lspactions.select
    vim.lsp.handlers["textDocument/references"] = lspactions.references
    vim.lsp.handlers["textDocument/definition"] = lspactions.definition
    vim.lsp.handlers["textDocument/declaration"] = lspactions.declaration
    vim.lsp.handlers["textDocument/implementation"] = lspactions.implementation
  end,
}
