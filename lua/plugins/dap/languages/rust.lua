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
  local target_subdirs = {
    "debug",
    "release-debug",
  }
  local roots = {
    core.file.root_path() .. "/target",
    os.getenv("CARGO_TARGET_DIR"),
  }

  local target_dirs = {}
  for _, root in pairs(roots) do
    for _, target_subdir in pairs(target_subdirs) do
      local target_dir = root .. "/" .. target_subdir .. "/"
      if core.file.file_or_dir_exists(target_dir) then
        table.insert(target_dirs, { path = target_dir, subdir = target_subdir })
      end
    end
  end

  local executables = {}
  for _, target in pairs(target_dirs) do
    for entry, entry_type in vim.fs.dir(target.path) do
      if entry_type == "file" then
        local perm = vim.fn.getfperm(target.path .. entry)
        if string.match(perm, "x", 3) then
          table.insert(executables, { path = target.path .. entry, display = target.subdir .. "/" .. entry })
        end
      end
    end
  end

  if #executables == 0 then
    vim.ui.input({
      prompt = "Path to executable: ",
      default = core.file.root_path(),
    }, function(input)
      set_program_path(input)
      run(configs)
    end)
  elseif #executables == 1 then
    set_program_path(executables[1])
    run(configs)
  else
    vim.ui.select(
      executables,
      { prompt = "Select executable", format_item = function(item) return item.display end },
      function(choice)
        if not choice then
          return
        end

        set_program_path(choice.path)
        run(configs)
      end
    )
  end
end
