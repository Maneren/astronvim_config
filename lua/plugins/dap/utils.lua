local function parse_args()
  local input = vim.fn.input("Arguments: ")

  -- Credit: https://github.com/mfussenegger/nvim-dap/discussions/1160

  local tokens = {}
  local current = ""
  local in_str = false
  local str_seek
  for c in string.gmatch(input, ".") do -- iterate through all chars
    if c == " " and not in_str then
      if string.len(current) > 0 then
        table.insert(tokens, current)
        current = ""
      end
    elseif c == '"' and not in_str then
      in_str = true
      str_seek = '"'
    elseif c == "'" and not in_str then
      in_str = true
      str_seek = "'"
    elseif c == str_seek and in_str then
      in_str = false
      table.insert(tokens, current)
      current = ""
    else
      current = current .. c
    end
  end
  if string.len(current) > 0 then
    table.insert(tokens, current)
  end
  return tokens
end

---@type LazySpec
return {
  "niuiic/dap-utils.nvim",
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
      local init = function()
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
      end

      local configs = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = nil,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          initCommands = init(),
        },
        {
          name = "Launch with args",
          type = "codelldb",
          request = "launch",
          program = nil,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = parse_args,
          initCommands = init(),
        },
      }

      local cmd = { "cargo", "build", "--bins", "--quiet", "--message-format", "json" }
      local out = vim.fn.systemlist(cmd)

      if vim.v.shell_error ~= 0 then
        local errors = vim.tbl_map(function(input)
          local _, json = pcall(vim.fn.json_decode, input)

          if type(json) == "table" and json.reason == "compiler-message" then
            return json.message.rendered
          end

          return nil
        end, out)
        vim.notify(table.concat(errors, "\n"), vim.log.levels.ERROR)
        return nil
      end

      local function set_program_path(path)
        vim.tbl_map(function(config) config.program = path end, configs)
      end

      local core = require("core")
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
          set_program_path(target_dir .. executable[1])
          run(configs)
        else
          vim.ui.select(executable, { prompt = "Select executable" }, function(choice)
            if not choice then
              return
            end

            set_program_path(target_dir .. choice)
            run(configs)
          end)
        end
      else
        vim.ui.input({
          prompt = "Path to executable: ",
          default = core.file.root_path() .. "/target/debug/",
        }, function(input)
          set_program_path(input)
          run(configs)
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
          args = parse_args,
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
          args = parse_args,
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
