--- Sticky keybinds
--- https://github.com/nvimtools/hydra.nvim
--- extends astrocommunity

local function keys(str)
  return function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true) end
end

local window_hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ ^ _K_ ^ ^    ^   _+_   ^      _s_: horizontally
 _h_ ^ ^ _l_  ^ _H_ ^ ^ _L_    _<_     _>_      _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ ^ _J_ ^ ^    ^   _-_   ^      _q_: close
 focus^^^^^^  ^window^^^^  ^^^_=_: equalize ^   _z_: max height
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^ ^  ^^ ^           ^   _x_: max width
 ^ _b_: choose buffer ^ ^^^ ^ ^ ^ ^ ^ ^ ^^ ^^   _o_: remain only
]]

---@type LazySpec
return {
  "nvimtools/hydra.nvim",
  event = "VeryLazy",
  dependencies = {
    "folke/snacks.nvim",
  },
  opts = {
    ["Side scroll"] = {
      mode = "n",
      body = "z",
      heads = {
        { "h", "5zh", { desc = "← one column" } },
        { "l", "5zl", { desc = "→ one column" } },
        { "H", "zH", { desc = "← half screen" } },
        { "L", "zL", { desc = "→ half screen" } },
      },
    },
    ["Notebook"] = {
      hint = "_j_/_k_: ↑/↓ | _o_/_O_: new cell ↓/↑ | _l_: run | _s_how/_h_ide | run _a_bove",
      config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
          type = "statuslinemanual",
        },
      },
      mode = { "n" },
      body = "<localleader>j",
      heads = {
        { "j", keys("]b"), { desc = "↓" } },
        { "k", keys("[b"), { desc = "↑" } },
        { "o", keys("/```<CR>:nohl<CR>o<CR>`<c-j>"), { desc = "new cell ↓", exit = true } },
        { "O", keys("?```.<CR>:nohl<CR><leader>kO<CR>`<c-j>"), { desc = "new cell ↑", exit = true } },
        { "l", ":QuartoSend<CR>", { desc = "run" } },
        { "s", ":noautocmd MoltenEnterOutput<CR>", { desc = "show" } },
        { "h", ":MoltenHideOutput<CR>", { desc = "hide" } },
        { "a", ":QuartoSendAbove<CR>", { desc = "run above" } },
        { "<esc>", nil, { exit = true, desc = false } },
        { "q", nil, { exit = true, desc = false } },
      },
    },
    ["Windows"] = {
      hint = window_hint,
      config = {
        invoke_on_body = true,
      },
      mode = "n",
      body = "<C-w>",
      heads = {
        { "h", "<C-w>h" },
        { "j", "<C-w>j" },
        { "k", "<C-w>k" },
        { "l", "<C-w>l" },

        { "H", "<C-w>H" },
        { "J", "<C-w>J" },
        { "K", "<C-w>K" },
        { "L", "<C-w>L" },

        { "<", "<C-w><" },
        { "-", "<C-w>-" },
        { "+", "<C-w>+" },
        { ">", "<C-w>>" },
        { "=", "<C-w>=", { desc = "equalize" } },

        { "s", "<C-w>s" },
        { "v", "<C-w>v" },

        { "w", "<C-w>w", { exit = true, desc = false } },
        { "<C-w>", "<C-w>w", { exit = true, desc = false } },
        { "z", "<c-w>_", { desc = "maximize height" } },
        { "x", "<c-w>|", { desc = "maximize width" } },
        { "o", "<C-w>o", { exit = true, desc = "remain only" } },

        {
          "b",
          function() require("snacks").picker.buffers() end,
          { exit = true, desc = "choose buffer" },
        },

        { "q", ":q<CR>", { desc = "close window" } },

        { "<Esc>", nil, { exit = true, desc = false } },
      },
    },
  },
}
