---@type LazySpec
return {
  "gbprod/yanky.nvim",
  event = "User AstroFile",
  dependencies = {
    { "kkharji/sqlite.lua" },
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>fy"] = { "<Cmd>Telescope yank_history<CR>", desc = "Find yanks" },
            ["y"] = { "<Plug>(YankyYank)", desc = "Yank text" },
            ["p"] = { "<Plug>(YankyPutAfter)", desc = "Put yanked text after cursor" },
            ["P"] = { "<Plug>(YankyPutBefore)", desc = "Put yanked text before cursor" },
            ["gp"] = { "<Plug>(YankyGPutAfter)", desc = "Put yanked text after selection" },
            ["gP"] = { "<Plug>(YankyGPutBefore)", desc = "Put yanked text before selection" },
            ["[y"] = { "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
            ["]y"] = { "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
            ["]p"] = { "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            ["[p"] = { "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
            ["]P"] = { "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            ["[P"] = { "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
            [">p"] = { "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
            ["<p"] = { "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
            [">P"] = { "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
            ["<P"] = { "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
            ["=p"] = { "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
            ["=P"] = { "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
            ["<C-P>"] = { "<Plug>(YankyPreviousEntry)", desc = "Previous put entry" },
            ["<C-N>"] = { "<Plug>(YankyNextEntry)", desc = "Next put entry" },
          },
          x = {
            ["y"] = { "<Plug>(YankyYank)", desc = "Yank text" },
            ["p"] = { "<Plug>(YankyPutAfter)", desc = "Put yanked text after cursor" },
            ["P"] = { "<Plug>(YankyPutBefore)", desc = "Put yanked text before cursor" },
            ["gp"] = { "<Plug>(YankyGPutAfter)", desc = "Put yanked text after selection" },
            ["gP"] = { "<Plug>(YankyGPutBefore)", desc = "Put yanked text before selection" },
          },
        },
      },
    },
  },
  opts = {
    highlight = { timer = 200 },
    ring = { storage = "sqlite" },
  },
}
