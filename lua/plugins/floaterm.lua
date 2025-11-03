local toggle_mapping = {
  function() require("floaterm").toggle() end,
  desc = "Toggle floaterm",
}

return {
  "nvzone/floaterm",
  dependencies = { "nvzone/volt" },
  opts = {
    border = false,
    size = { h = 92, w = 90 },

    mappings = {
      sidebar = nil,
      term = function(buf)
        local utils = require("floaterm.utils")
        local state = require("floaterm.state")

        for index, term in ipairs(state.terminals) do
          vim.keymap.set(
            { "n", "t" },
            ("<M-%d>"):format(index),
            function() utils.switch_buf(term.buf) end,
            { buffer = buf }
          )
        end
      end,
    },

    terminals = {
      { name = "Terminal" },
      { name = "btop", cmd = "btop" },
    },
  },
  cmd = "FloatermToggle",
  specs = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>tt"] = toggle_mapping,
            ["<F8>"] = toggle_mapping,
          },
          t = {
            ["<F8>"] = toggle_mapping,
          },
        },
      },
    },
  },
}
