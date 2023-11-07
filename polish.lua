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
    "bash-debug-adapter",
    "bash-language-server",
    "black",
    "cbfmt",
    "chrome-debug-adapter",
    "clang-format",
    "clangd",
    "codelldb",
    "cpplint",
    "cpptools",
    "csharp-language-server",
    "csharpier",
    "css-lsp",
    "diagnostic-languageserver",
    "dockerfile-language-server",
    "eslint-lsp",
    "fixjson",
    "grammarly-languageserver",
    "html-lsp",
    "js-debug-adapter",
    "jsonlint",
    "ltex-ls",
    "lua-language-server",
    "markdownlint",
    "mdformat",
    "omnisharp",
    "python-lsp-server",
    "ruff-lsp",
    "rust-analyzer",
    "selene",
    "shellcheck",
    "shellharden",
    "shfmt",
    "sqlfmt",
    "stylua",
    "taplo",
    "texlab",
    "typescript-language-server",
    "yaml-language-server",
    "yamlfmt",
    "yamllint",
  }

  local installed = set(require("mason-registry").get_installed_package_names())

  local to_install = {}

  for package in pairs(ensure_installed) do
    if not installed[package] then
      to_install.insert(to_install, package)
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
