--- Installer for LSPs and formatters
--- https://github.com/williamboman/mason.nvim

---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    -- TODO: switch back once https://github.com/williamboman/mason.nvim/pull/1640 is merged
    url = "https://github.com/KingMichaelPark/mason.nvim",
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
        "black",
        "blackd-client",
        "cbfmt",
        "codelldb",
        "cpplint",
        "cpptools",
        "csharpier",
        "fixjson",
        "harper-ls",
        "jsonlint",
        "ltex-ls",
        "markdown-oxide",
        "markdownlint",
        "neocmakelsp",
        "prettierd",
        "robotframework-lsp",
        "shellcheck",
        "shellharden",
        "sonarlint-language-server",
        "sourcery",
        "sqlfmt",
        "stylelint-lsp",
        "tectonic",
        "texlab",
        "twiggy-language-server",
        "yamlfmt",
        "yamllint",
      },
    },
  },
}
