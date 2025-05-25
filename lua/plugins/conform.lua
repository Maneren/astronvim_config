--- Smart format on save
--- https://github.com/stevearc/conform.nvim
--- extends astrocommunity
--- adapted from https://code.mehalter.com/AstroNvim_user/~files/v5/lua/plugins/conform.lua

---@type LazySpec
return {
  "stevearc/conform.nvim",
  dependencies = { "williamboman/mason.nvim" },
  ---@param opts conform.setupOpts
  opts = function(_, opts)
    local buf_utils = require("astrocore.buffer")
    opts.default_format_opts = { lsp_format = "fallback" }

    opts.format_on_save = function(bufnr)
      if vim.g.autoformat == nil then
        vim.g.autoformat = true
      end
      local autoformat = vim.b[bufnr].autoformat
      if autoformat == nil then
        autoformat = vim.g.autoformat
      end
      if autoformat then
        return { timeout_ms = 2000 }
      end
    end

    local function is_file_buffer(bufnr) return buf_utils.is_valid(bufnr) and buf_utils.has_filetype(bufnr) end

    opts.formatters_by_ft = {
      ["*"] = function(bufnr) return is_file_buffer(bufnr) and { "injected" } or {} end,
      fish = { "fish_indent" },
      go = { "gofmt" },
      just = { "just" },
      lua = { "stylua" },
      python = { "ruff" },
      rust = { "rustfmt" },
      sh = { "beautysh" },
      sql = { "sqlfmt" },
      tex = { "tex-fmt" },
      toml = { "taplo" },
      ["_"] = function(bufnr)
        return is_file_buffer(bufnr) and { "trim_whitespace", "trim_newlines", "squeeze_blanks" } or {}
      end,
    }

    -- prettier filetypes
    vim.tbl_map(function(ft) opts.formatters_by_ft[ft] = { "prettierd", "prettier", stop_after_first = true } end, {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "less",
      "html",
      "yaml",
      "yaml.ansible",
      "yaml.cfn",
      "markdown",
      "markdown.mdx",
      "graphql",
      "handlebars",
      "php",
      "twig",
    })
    vim.tbl_map(
      function(ft) opts.formatters_by_ft[ft] = { "fixjson", "prettierd", "prettier", stop_after_first = true } end,
      {
        "json",
        "jsonc",
        "json5",
      }
    )

    vim.tbl_map(function(ft) opts.formatters_by_ft[ft] = { "clang-format" } end, {
      "c",
      "cpp",
      "cuda",
      "objc",
      "objcpp",
    })
  end,
  specs = {
    { "AstroNvim/astrolsp", opts = { formatting = { disabled = true } } },
    {
      "AstroNvim/astrocore",
      opts = {
        options = { opt = { formatexpr = "v:lua.require'conform'.formatexpr()" } },
        commands = {
          Format = {
            function(args)
              local range = nil
              if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                  start = { args.line1, 0 },
                  ["end"] = { args.line2, end_line:len() },
                }
              end
              require("conform").format { async = true, range = range }
            end,
            desc = "Format buffer",
            range = true,
          },
        },
      },
    },
  },
}
