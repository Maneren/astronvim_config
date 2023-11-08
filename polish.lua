return function()
  require("neodev").setup {
    library = { plugins = { "neotest" }, types = true },
  }

  local dap = require("dap")
  dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
    name = "lldb",
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input {
          prompt = "Path to executable: ",
          default = vim.fn.getcwd() .. "/",
          completion = "file",
        }
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

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
    "grammarly-languageserver",
    "haskell-language-server",
    "html-lsp",
    "js-debug-adapter",
    "jsonlint",
    "json-lsp",
    "ltex-ls",
    "lua-language-server",
    "markdownlint",
    "mdformat",
    "omnisharp",
    "python-lsp-server",
    "quick-lint-js",
    "ruff",
    "ruff-lsp",
    "rust-analyzer",
    "rustywind",
    "selene",
    "shellcheck",
    "shellharden",
    "shfmt",
    "sourcery",
    "sqlfmt",
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

  local installed = set(require("mason-registry").get_installed_package_names())

  local to_install = {}

  for package in pairs(ensure_installed) do
    if not installed[package] then
      table.insert(to_install, package)
    end
  end

  for package in pairs(installed) do
    if not ensure_installed[package] then
      vim.print("'" .. package .. "' is installed but not in ensure_installed")
    end
  end

  if #to_install > 0 then
    vim.cmd("MasonInstall " .. table.concat(to_install, " "))
  end
end
