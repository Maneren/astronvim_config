---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<Leader>tt", "<Cmd>ToggleTerm direction=tab<CR>", desc = "ToggleTerm tab" },
    },
  },
  {
    "ryanmsnyder/toggleterm-manager.nvim",
    lazy = true,
    init = function(plugin) require("astrocore").on_load("telescope.nvim", plugin.name) end,
    dependencies = {
      "akinsho/toggleterm.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>tm"] = { "<cmd>Telescope toggleterm_manager<cr>", desc = "Toggleterm Manager" },
            },
          },
        },
      },
    },
    opts = function(_, opts)
      local term_icon = require("astroui").get_icon("Terminal")
      local toggleterm_manager = require("toggleterm-manager")
      local actions = toggleterm_manager.actions

      local open = { action = actions.toggle_term, exit_on_action = true }
      local create = { action = actions.create_term, exit_on_action = false }
      local rename = { action = actions.rename_term, exit_on_action = false }
      local delete = { action = actions.delete_term, exit_on_action = false }

      return require("astrocore").extend_tbl(opts, {
        titles = { prompt = term_icon .. " Terminals" },
        results = { term_icon = term_icon },
        mappings = {
          n = {
            ["<CR>"] = open,
            ["<C-r>"] = rename,
            ["<C-d>"] = delete,
            ["<C-n>"] = create,
          },
          i = {
            ["<CR>"] = open,
            ["<C-r>"] = rename,
            ["<C-d>"] = delete,
            ["<C-n>"] = create,
          },
        },
      })
    end,
  },
}
