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
        guifont = { "Iosevka", ":h14" },
      },
      g = {
        neovide_cursor_vfx_mode = "pixiedust",
        neovide_remember_window_size = true,
        neovide_scroll_animation_length = 0,
        neovide_hide_mouse_when_typing = true,
        neovide_cursor_animate_command_line = false,
      },
    },
    mappings = {
      n = {
        -- make copy-pasting use the system clipboard by default
        p = { '"+p' },
        P = { '"+P' },
      },
      v = {
        -- Also in visual mode
        x = { '"+x' },
        y = { '"+y' },
        p = { '"_d"+p' },
        P = { '"_d"+P' },
      },
    },
  },
}
