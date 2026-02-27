--- Installer for LSPs and formatters
--- https://github.com/mason-org/mason.nvim
--- extends AstroNvim

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
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "actionlint",
        "beautysh",
        "bibtex-tidy",
        "cbfmt",
        "codelldb",
        "cpplint",
        "cpptools",
        "fixjson",
        "harper-ls",
        "hlint",
        "jsonlint",
        "ltex-ls-plus",
        "markdown-oxide",
        "markdownlint",
        "neocmakelsp",
        "prettierd",
        "shellcheck",
        "shellharden",
        "sqlfmt",
        "stylelint-language-server",
        "tectonic",
        "tex-fmt",
        "texlab",
        "yamlfmt",
        "yamllint",
      })

      -- Remove binaries that are already installed to prevent duplicate install
      -- with system packages
      for i = #opts.ensure_installed, 1, -1 do
        local name = opts.ensure_installed[i]
        local spec = require("mason-registry").get_package(name).spec

        if vim.iter(spec.bin):all(function(k, _) return vim.fn.executable(k) == 1 end) then
          table.remove(opts.ensure_installed, i)
          vim.lsp.enable(name)
        end
      end

      return opts
    end,
  },
}
