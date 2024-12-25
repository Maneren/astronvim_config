--- Search devdocs
--- https://github.com/luckasRanarison/nvim-devdocs
--- adapted from astrocommunity

-- install command:
-- nvim --headless +"DevdocsInstall rust javascript typescript html css http dom bash docker git latex markdown node lua npm python tailwindcss c"
-- Note: may take a long time but also often hang when done, so check a task
-- manager and kill the process if you waited a lot and it seems idle

local prefix = "<Leader>f"

---@type LazySpec
return {
  "luckasRanarison/nvim-devdocs",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = {
    "DevdocsFetch",
    "DevdocsInstall",
    "DevdocsUninstall",
    "DevdocsOpen",
    "DevdocsOpenFloat",
    "DevdocsOpenCurrentFloat",
    "DevdocsUpdate",
    "DevdocsUpdateAll",
    "DevdocsToggle",
  },
  opts = {
    previewer_cmd = vim.fn.executable("glow") == 1 and "glow" or nil,
    cmd_args = { "-w", "200", "-s", "dark" },
    picker_cmd = true,
    picker_cmd_args = { "-p", "-s", "dark" },
    filetypes = {
      typescript = { "node", "javascript", "typescript" },
    },
    float_win = {
      relative = "editor",
      height = 35,
      width = 120,
      border = "rounded",
    },
    after_open = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
    end,
  },
  specs = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            [prefix .. "dd"] = { "<Cmd>DevdocsOpenCurrentFloat<CR>", desc = "Find Devdocs for current file" },
            [prefix .. "dt"] = { "<Cmd>DevdocsToggle<CR>", desc = "Toggle last Devdocs item" },
            [prefix .. "D"] = { "<Cmd>DevdocsOpenFloat<CR>", desc = "Find Devdocs" },
          },
        },
      },
    },
  },
}
