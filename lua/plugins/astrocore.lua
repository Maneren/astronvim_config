---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "auto",
        wrap = false,
        guifont = { "Iosevka", vim.fn.hostname() == "swift5pro" and ":h8" or ":h14" },
      },
      g = {
        neovide_cursor_vfx_mode = "pixiedust",
        neovide_hide_mouse_when_typing = true,
        neovide_cursor_animate_command_line = false,
        neovide_far_scroll_lines = 200,
        neovide_floating_shadow = true,
        neovide_floating_z_height = 10,
        neovide_light_angle_degrees = 45,
        neovide_light_radius = 5,

        vimtex_compiler_method = "tectonic",
      },
    },
    mappings = {
      t = {
        -- escape in terminal mode
        ["<C-ESC>"] = { "<C-\\><C-n>" },
        -- paste in terminal
        ["<C-v>"] = { "<C-\\><C-n>pi", desc = "Paste from clipboard" },
      },
    },
  },
}
