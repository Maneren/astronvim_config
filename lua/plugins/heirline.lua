-- based on https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/recipes/heirline-clock-statusline/init.lua
return {
  "rebelot/heirline.nvim",
  dependencies = {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      icons = {
        Clock = "",
      },
    },
  },
  opts = function(_, opts)
    local status = require("astroui.status")

    opts.statusline[#opts.statusline + 1] = status.component.builder {
      {
        provider = function()
          local time = os.date("%H:%M") -- show hour and minute in 24 hour format
          ---@cast time string
          return status.utils.stylize(time, {
            icon = { kind = "Clock", padding = { right = 1 } }, -- add icon
            padding = { right = 1 }, -- pad the right side
          })
        end,
      },
      update = { "ModeChanged", pattern = "*:*", callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end) },
      hl = status.hl.get_attributes("mode"),
      init = status.init.update_events {
        { "User", pattern = "UpdateTime", callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end) },
      },
      surround = {
        separator = "right",
        color = function() return { main = status.hl.mode_bg(), left = "file_info_bg" } end,
      },
    }

    local uv = vim.uv or vim.loop
    uv.new_timer():start( -- timer for updating the time
      (60 - tonumber(os.date("%S"))) * 1000, -- offset timer based on current seconds past the minute
      60000, -- update every 60 seconds
      vim.schedule_wrap(function() vim.api.nvim_exec_autocmds("User", { pattern = "UpdateTime", modeline = false }) end)
    )
  end,
}
