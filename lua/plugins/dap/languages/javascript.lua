return function(run)
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
end
