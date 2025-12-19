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
      -- TODO: wait for rustacean.nvim to update
      -- rust_analyzer = false, -- rustacean.nvim
      omnisharp = false, -- csharp.nvim
    },
    autocmds = {
      lsp_document_highlight = {
        cond = "textDocument/documentHighlight",
        {
          event = { "CursorHold", "CursorHoldI" },
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
      },
    },
  },
  specs = {
    -- TODO: wait for rustacean.nvim to update
    { "mrcjkb/rustaceanvim", enabled = false },
  },
}
