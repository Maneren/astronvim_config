return function()
  local function set(array)
    local output = {}
    for _, v in ipairs(array) do
      output[v] = true
    end
    return output
  end

  local ensure_installed = set {
    "actionlint",
    "asm-lsp",
    "bash-debug-adapter",
    "bash-language-server",
    "beautysh",
    "black",
    "cbfmt",
    "chrome-debug-adapter",
    "clangd",
    "clang-format",
    "codelldb",
    "cpplint",
    "cpptools",
    "csharpier",
    "csharp-language-server",
    "css-lsp",
    "debugpy",
    "diagnostic-languageserver",
    "dockerfile-language-server",
    "eslint-lsp",
    "fixjson",
    "haskell-language-server",
    "html-lsp",
    "js-debug-adapter",
    "jsonlint",
    "json-lsp",
    "ltex-ls",
    "lua-language-server",
    "markdownlint",
    "mypy",
    "omnisharp",
    "python-lsp-server",
    "quick-lint-js",
    "ruff",
    "ruff-lsp",
    "rustywind",
    "selene",
    "shellcheck",
    "shellharden",
    "shfmt",
    "sourcery",
    "sqlfmt",
    "sql-formatter",
    "sqlls",
    "stylelint-lsp",
    "stylua",
    "tailwindcss-language-server",
    "taplo",
    "texlab",
    "typescript-language-server",
    "yamlfmt",
    "yaml-language-server",
    "yamllint",
  }

  vim.api.nvim_create_user_command("SyncMason", function()
    local installed = set(require("mason-registry").get_installed_package_names())

    local to_install = {}

    for package in pairs(ensure_installed) do
      if not installed[package] then
        table.insert(to_install, package)
      end
    end

    local printed_error = false

    for package in pairs(installed) do
      if not ensure_installed[package] then
        if not printed_error then
          vim.print("The following packages are installed but not declared:")
          printed_error = true
        end
        vim.print('"' .. package .. '"')
      end
    end

    if #to_install > 0 then
      vim.ui.input({ prompt = table.concat(to_install, ", ") .. "\n\nInstall packages (Y/n) " }, function(input)
        if input == "Y" or input == "y" or input == "" then
          vim.cmd("MasonInstall " .. table.concat(to_install, " "))
        end
      end)
    end
  end, {})
end
