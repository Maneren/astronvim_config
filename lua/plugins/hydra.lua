--- @type LazySpec
return {
  "nvimtools/hydra.nvim",
  event = "VeryLazy",
  dependencies = {
    "jlanzarotta/bufexplorer",
    "sindrets/winshift.nvim",
    "mrjones2014/smart-splits.nvim",
  },
  config = function()
    local Hydra = require("hydra")

    local splits = require("smart-splits")

    local cmd = require("hydra.keymap-util").cmd
    local pcmd = require("hydra.keymap-util").pcmd

    local window_hint = [[
     ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
     ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
     ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally 
     _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
     ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
     focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
     ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
    ]]

    Hydra {
      name = "Windows",
      hint = window_hint,
      config = {
        invoke_on_body = true,
      },
      mode = "n",
      body = "<C-w>",
      heads = {
        { "h", "<C-w>h" },
        { "j", "<C-w>j" },
        { "k", pcmd("wincmd k", "E11", "close") },
        { "l", "<C-w>l" },

        { "H", cmd("WinShift left") },
        { "J", cmd("WinShift down") },
        { "K", cmd("WinShift up") },
        { "L", cmd("WinShift right") },

        { "<C-h>", function() splits.resize_left(2) end },
        { "<C-j>", function() splits.resize_down(2) end },
        { "<C-k>", function() splits.resize_up(2) end },
        { "<C-l>", function() splits.resize_right(2) end },
        { "=", "<C-w>=", { desc = "equalize" } },

        { "s", pcmd("split", "E36") },
        { "<C-s>", pcmd("split", "E36"), { desc = false } },
        { "v", pcmd("vsplit", "E36") },
        { "<C-v>", pcmd("vsplit", "E36"), { desc = false } },

        { "w", "<C-w>w", { exit = true, desc = false } },
        { "<C-w>", "<C-w>w", { exit = true, desc = false } },

        { "o", "<C-w>o", { exit = true, desc = "remain only" } },
        { "<c-o>", "<C-w>o", { exit = true, desc = false } },

        { "c", pcmd("close", "E444") },
        { "q", pcmd("close", "E444"), { desc = "close window" } },
        { "<C-c>", pcmd("close", "E444"), { desc = false } },
        { "<C-q>", pcmd("close", "E444"), { desc = false } },

        { "<Esc>", nil, { exit = true, desc = false } },
      },
    }

    Hydra {
      name = "Side scroll",
      mode = "n",
      body = "z",
      heads = {
        { "h", "5zh" },
        { "l", "5zl", { desc = "←/→" } },
        { "H", "zH" },
        { "L", "zL", { desc = "←/→ half screen" } },
      },
    }
  end,
}
