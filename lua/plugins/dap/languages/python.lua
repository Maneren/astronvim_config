return function(run)
  run {
    {
      name = "Launch file",
      type = "python",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      name = "Launch file with args",
      type = "python",
      request = "launch",
      program = "${file}",
      args = require("plugins.dap.languages.common").parse_args,
      cwd = "${workspaceFolder}",
    },
  }
end
