return function(run)
  local init = function()
    local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

    assert(vim.v.shell_error == 0, "failed to get rust sysroot using `rustc --print sysroot`: " .. rustc_sysroot)

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
      args = require("plugins.dap.languages.common").parse_args,
      initCommands = init(),
    },
    {
      name = "Attach",
      type = "codelldb",
      request = "attach",
      pid = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
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
end
