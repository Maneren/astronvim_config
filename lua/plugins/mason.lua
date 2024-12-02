---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    enabled = false,
  },
  {
    -- TODO: switch back once https://github.com/williamboman/mason.nvim/pull/1640 is merged
    "KingMichaelPark/mason.nvim",
    name = "mason",
    opts = { pip = { use_uv = true } },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "asm_lsp",
        "diagnosticls",
        "ltex",
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
        "prettierd",
        "rustywind",
        "shellcheck",
        "shellharden",
        "sonarlint-language-server",
        "sqlfmt",
        "yamlfmt",
        "yamllint",
      })
      opts.handlers.prettierd = function(source_name, methods)
        local null_ls = require("null-ls")
        for _, method in ipairs(methods) do
          null_ls.register(null_ls.builtins[method][source_name].with { filetypes = { "php", "twig" } })
        end
      end
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
