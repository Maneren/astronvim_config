--- Installer for LSPs and formatters
--- https://github.com/mason-org/mason.nvim
--- extends AstroNvim

---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    config = function(_, opts)
      require("mason").setup(opts)

      local Result = require("mason-core.result")
      local path = require("mason-core.path")
      local compiler = require("mason-core.installer.compiler")
      local pypi = require("mason-core.installer.compiler.compilers.pypi")

      local extend = { __index = pypi }

      local uv = {
        ---@async
        ---@param ctx InstallContext
        ---@param source ParsedPypiSource
        install = function(ctx, source)
          if vim.fn.executable("uv") ~= 1 then
            return pypi.install(ctx, source)
          end
          return Result.try(function(try)
            ctx:promote_cwd()
            try(ctx.spawn.uv { "venv", "venv" })
            try(ctx.spawn.uv {
              "pip",
              "install",
              source.extra and ("%s[%s]==%s"):format(source.package, source.extra, source.version)
                or ("%s==%s"):format(source.package, source.version),
              source.extra_packages or vim.NIL,
              env = {
                VIRTUAL_ENV = path.concat { ctx.cwd:get(), "venv" },
              },
            })
          end)
        end,
      }

      setmetatable(uv, extend)

      compiler.register_compiler("pypi", uv)
    end,
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
        "fixjson",
        "harper-ls",
        "hlint",
        "jsonlint",
        "ltex-ls-plus",
        "markdownlint",
        "neocmakelsp",
        "prettierd",
        "shellcheck",
        "shellharden",
        "stylelint-language-server",
        "tectonic",
        "tex-fmt",
        "texlab",
        "yamlfmt",
        "yamllint",
      })

      local get_package = require("mason-registry").get_package

      -- Remove binaries that are already installed to prevent duplicate install
      -- with system packages
      for i = #opts.ensure_installed, 1, -1 do
        local name = opts.ensure_installed[i]
        local spec = get_package(name).spec

        if vim.iter(spec.bin):all(function(k, _) return vim.fn.executable(k) == 1 end) then
          table.remove(opts.ensure_installed, i)
          vim.lsp.enable(name)
        end
      end
      return opts
    end,
  },
}
