--- Installer for LSPs and formatters
--- https://github.com/mason-org/mason.nvim

---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    url = "https://github.com/KingMichaelPark/mason.nvim",
    branch = "feat/add-uv-as-pypi-source",
    opts = { pip = { use_uv = true } },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "actionlint",
        "asmfmt",
        "asm-lsp",
        "beautysh",
        "cbfmt",
        "codelldb",
        "cpplint",
        "cpptools",
        "csharpier",
        "fixjson",
        "harper-ls",
        "hlint",
        "jsonlint",
        "ltex-ls",
        "markdown-oxide",
        "markdownlint",
        "neocmakelsp",
        "ormolu",
        "prettierd",
        "robotframework-lsp",
        "shellcheck",
        "shellharden",
        "sqlfmt",
        "stylelint-lsp",
        "tectonic",
        "tex-fmt",
        "texlab",
        "twiggy-language-server",
        "yamlfmt",
        "yamllint",
      },
    },
  },
}
