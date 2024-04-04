---@type LazySpec
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "asm_lsp",
        "diagnosticls",
        "ltex",
        "omnisharp",
        "sourcery",
        "stylelint_lsp",
        "texlab",
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "actionlint",
        "asmfmt",
        "beautysh",
        "black",
        "cbfmt",
        "cmakelang",
        "cpplint",
        "csharpier",
        "fixjson",
        "jsonlint",
        "markdownlint",
        "rustywind",
        "shellharden",
        "sqlfmt",
        "yamlfmt",
        "yamllint",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "codelldb",
        "cpptools",
      })
    end,
  },
}
