return function(run)
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
      args = require("plugins.dap.languages.common").parse_args,
    },
  }
end
