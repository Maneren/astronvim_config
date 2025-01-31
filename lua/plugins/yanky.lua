--- Yank history manager
--- https://github.com/gbprod/yanky.nvim
--- adapted from astrocommunity to remove telescope dependency and unused
--- mappings

---@type LazySpec
return {
  "gbprod/yanky.nvim",
  event = "BufEnter",
  dependencies = {
    { "kkharji/sqlite.lua" },
  },
  opts = function()
    return {
      highlight = { timer = 200 },
      ring = { storage = "sqlite" },
    }
  end,
  specs = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>fy"] = { "<Cmd>YankyRingHistory<CR>", desc = "Find yanks" },
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
}
