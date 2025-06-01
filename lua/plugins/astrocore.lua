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
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "auto",
        wrap = false,
        textwidth = 80,
        guifont = { "Iosevka Nerd Font", ":h13" },
      },
      g = {
        neovide_cursor_vfx_mode = "pixiedust",
        neovide_hide_mouse_when_typing = true,
        neovide_cursor_animate_command_line = false,
        neovide_far_scroll_lines = 200,
        neovide_floating_shadow = true,
        neovide_floating_z_height = 10,
        neovide_floating_corner_radius = 0.6,
        neovide_light_angle_degrees = 45,
        neovide_light_radius = 5,
        neovide_padding_top = 4,
        neovide_padding_right = 4,
        neovide_padding_left = 6,
        neovide_opacity = 0.97,
        neovide_normal_opacity = 0.97,

        vimtex_compiler_method = "tectonic",
      },
    },
    commands = {
      Messages = {
        function()
          local scratch_buffer = vim.api.nvim_create_buf(false, true)
          vim.bo[scratch_buffer].filetype = "vim"
          local messages = vim.split(vim.fn.execute("messages", "silent"), "\n")
          vim.api.nvim_buf_set_text(scratch_buffer, 0, 0, 0, 0, messages)
          vim.cmd("vertical sbuffer " .. scratch_buffer)
          vim.opt_local.wrap = true
          vim.bo.buflisted = false
          vim.bo.bufhidden = "wipe"
          vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = scratch_buffer })
        end,
        desc = "Show messages in a buffer",
      },
    },
    mappings = {
      t = {
        -- escape in terminal mode
        ["<C-ESC>"] = { "<C-\\><C-n>" },
        -- paste in terminal
        ["<C-v>"] = { "<C-\\><C-n>pi", desc = "Paste from clipboard" },
      },
      n = {
        H = { "^", desc = "First non-blank" },
        L = { "$", desc = "Last non-blank" },
      },
      x = {
        H = { "^", desc = "First non-blank" },
        L = { "$", desc = "Last non-blank" },
      },
      o = {
        H = { "^", desc = "First non-blank" },
        L = { "$", desc = "Last non-blank" },
      },
    },
    rooter = {
      detector = {
        "lsp",
        { "lua", "MakeFile", "package.json", "Cargo.toml", "CMakeLists.txt" },
        { ".git", "_darcs", ".hg", ".bzr", ".svn" },
      },
      autochdir = true,
      scope = "global",
      notify = true,
    },
  },
}
