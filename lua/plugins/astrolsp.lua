---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      autoformat = true,
      codelens = true,
      inlay_hints = true,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
        ignore_filetypes = {},
      },
      disabled = {
        "csharp_ls",
        "omnisharp",
        "sqls",
      },
      timeout_ms = 2000,
    },
    handlers = {
      omnisharp = false, -- csharp.nvim
    },
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
      },
    },
  },
}
