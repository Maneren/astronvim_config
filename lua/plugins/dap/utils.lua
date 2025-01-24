---@type LazySpec
return {
  "niuiic/dap-utils.nvim",
  event = "BufEnter",
  dependencies = {
    "mfussenegger/nvim-dap",
    "niuiic/core.nvim",
    "rcarriga/nvim-dap-ui",
    "nvim-telescope/telescope.nvim",
    {
      "astrocore",
      opts = {
        mappings = {
          n = {
            ["<F5>"] = { function() require("dap-utils").continue() end, desc = "Start/Continue" },
            ["<Leader>dc"] = { function() require("dap-utils").continue() end, desc = "Start/Continue (F5)" },
            ["<Leader>dl"] = { function() require("dap").run_last() end, desc = "Run last config" },
          },
        },
      },
    },
  },
  opts = {
    rust = function(run)
      local config = {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = nil,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        initCommands = function()
          local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

          local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
          local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

          local commands = {}
          local file = io.open(commands_file, "r")
          if file then
            for line in file:lines() do
              table.insert(commands, line)
            end
            file:close()
          end
          table.insert(commands, 1, script_import)

          return commands
        end,
      }
      local core = require("core")
      vim.cmd("!cargo build")
      local root_path = core.file.root_path()
      local target_dir = os.getenv("CARGO_TARGET_DIR") .. "/debug/"
      if core.file.file_or_dir_exists(target_dir) then
        local executable = {}
        for path, path_type in vim.fs.dir(target_dir) do
          if path_type == "file" then
            local perm = vim.fn.getfperm(target_dir .. path)
            if string.match(perm, "x", 3) then
              table.insert(executable, path)
            end
          end
        end
        if #executable == 1 then
          config.program = target_dir .. executable[1]
          run(config)
        else
          vim.ui.select(executable, { prompt = "Select executable" }, function(choice)
            if not choice then
              return
            end
            config.program = target_dir .. choice
            run(config)
          end)
        end
      else
        vim.ui.input({
          prompt = "Path to executable: ",
          default = root_path .. "/target/debug/",
        }, function(input)
          config.program = input
          run(config)
        end)
      end
    end,

    javascript = function(run)
      local core = require("core")
      run {
        {
          name = "Launch project",
          type = "pwa-node",
          request = "launch",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "pnpm",
          runtimeArgs = {
            "debug",
          },
        },
        {
          name = "Launch cmd",
          type = "pwa-node",
          request = "launch",
          cwd = core.file.root_path(),
          runtimeExecutable = "pnpm",
          runtimeArgs = {
            "debug:cmd",
          },
        },
        {
          name = "Launch file",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          name = "Attach",
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end,

    python = function(run)
      run {
        {
          name = "Launch file",
          type = "python",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }
    end,

    cpp = function(run)
      run {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = require("dap.utils").pick_file,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Launch with args",
          type = "codelldb",
          request = "launch",
          program = require("dap.utils").pick_file,
          args = function() return vim.fn.split(vim.fn.input("Arguments: "), " ") end,
          cwd = "${workspaceFolder}",
        },
      }
    end,

    c = function(run)
      run {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = require("dap.utils").pick_file,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Launch with args",
          type = "lldb",
          request = "launch",
          program = require("dap.utils").pick_file,
          args = function() return vim.fn.split(vim.fn.input("Arguments: "), " ") end,
          cwd = "${workspaceFolder}",
        },
      }
    end,

    cs = function(run)
      run {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = require("dap.utils").pick_file,
        },
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = require("dap.utils").pick_file,
          args = function() return vim.fn.split(vim.fn.input("Arguments: "), " ") end,
        },
      }
    end,
  },

}
