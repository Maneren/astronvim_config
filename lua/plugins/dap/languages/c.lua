return function(run)
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
      args = require("plugins.dap.languages.common").parse_args,
      cwd = "${workspaceFolder}",
    },
    {
      name = "Attach",
      type = "codelldb",
      request = "attach",
      pid = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end
