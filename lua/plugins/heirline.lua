--- Statusline
--- https://github.com/NTBBloodbath/heirline.nvim

-- based on AstroNvim's recipes heirline-nvchad-statusline and heirline-clock-statusline
-- with slight modifications
--
-- https://docs.astronvim.com/recipes/status/#default-statusline-with-clock
---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      icons = {
        VimIcon = "",
        ScrollText = "",
        GitBranch = "",
        GitAdd = "",
        GitChange = "",
        GitDelete = "",
      },
      status = {
        separators = {
          left = { "", "" },
          right = { " ", "" },
        },
        colors = function(hl)
          local get_hlgroup = require("astroui").get_hlgroup
          local comment_fg = get_hlgroup("Comment").fg
          hl.git_branch_fg = comment_fg
          hl.git_added = comment_fg
          hl.git_changed = comment_fg
          hl.git_removed = comment_fg
          hl.blank_bg = get_hlgroup("FoldColumn").fg
          hl.file_info_bg = get_hlgroup("Visual").bg
          hl.nav_icon_bg = get_hlgroup("String").fg
          hl.nav_fg = hl.nav_icon_bg
          return hl
        end,
        attributes = {
          mode = { bold = true },
        },
        icon_highlights = {
          file_icon = {
            statusline = false,
          },
        },
      },
    },
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require("astroui.status")
      opts.statusline = {
        -- default highlight for the entire statusline
        hl = { fg = "fg", bg = "bg" },

        -- vim mode
        status.component.mode {
          mode_text = {
            icon = { kind = "VimIcon", padding = { right = 1, left = 1 } },
          },
          padding = { right = 1 },
          surround = {
            separator = "left",
            color = function() return { main = status.hl.mode_bg(), right = "blank_bg" } end,
          },
        },
        -- supposedly grey separator
        status.component.builder {
          { provider = "" },
          surround = {
            separator = "left",
            color = { main = "blank_bg", right = "file_info_bg" },
          },
        },
        -- currently open file
        status.component.file_info {
          filename = { fallback = "Empty" },
          filetype = false,
          padding = { right = 1 },
          surround = { separator = "left", condition = false },
        },
        status.component.git_branch {
          git_branch = { padding = { left = 1 } },
          surround = { separator = "none" },
        },
        status.component.git_diff {
          padding = { left = 1 },
          surround = { separator = "none" },
        },
        status.component.fill(),
        status.component.lsp {
          lsp_client_names = false,
          surround = { separator = "none", color = "bg" },
        },
        status.component.fill(),
        status.component.diagnostics { surround = { separator = "right" } },
        status.component.lsp {
          lsp_progress = false,
          surround = { separator = "right" },
        },
        -- file percentage
        {
          status.component.builder {
            { provider = require("astroui").get_icon("ScrollText") },
            padding = { right = 1 },
            hl = { fg = "bg" },
            surround = {
              separator = "right",
              color = { main = "nav_icon_bg" },
            },
          },
          status.component.nav {
            percentage = { padding = { right = 1 } },
            scrollbar = false,
            surround = { separator = "none", color = "file_info_bg" },
          },
        },
        status.component.builder {
          {
            provider = function()
              local time = os.date("%H:%M")
              ---@cast time string
              return status.utils.stylize(time, {
                icon = { kind = "Clock", padding = { right = 1 } },
                padding = { right = 1 },
              })
            end,
          },
          -- update color based on mode
          update = {
            "ModeChanged",
            pattern = "*:*",
            callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
          },
          hl = status.hl.get_attributes("mode"),
          init = status.init.update_events {
            {
              "User",
              pattern = "UpdateTime",
              callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
            },
          },
          surround = {
            separator = "right",
            color = function() return { main = status.hl.mode_bg(), left = "file_info_bg" } end,
          },
        },
      }

      -- timer for updating the time
      local uv = vim.uv or vim.loop
      uv.new_timer():start(
        (60 - tonumber(os.date("%S"))) * 1000, -- offset timer based on current seconds past the minute
        60000, -- update every 60 seconds
        vim.schedule_wrap(
          function() vim.api.nvim_exec_autocmds("User", { pattern = "UpdateTime", modeline = false }) end
        )
      )
    end,
  },
}
