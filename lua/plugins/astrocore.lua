--- Find the outermost Cargo/uv workspace root containing the buffer.
--- Returns an empty table when the buffer is not part of a workspace, so the
--- remaining detectors can fall back to the usual behavior.
---@param bufnr integer
---@return string[]
local function workspace_root(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" then
    return {}
  end

  local markers = {
    { file = "Cargo.toml", section = "[workspace]" },
    { file = "pyproject.toml", section = "[tool.uv.workspace]" },
  }

  ---@param file string
  ---@param section string
  local function has_section(file, section)
    local fd = io.open(file, "r")
    if not fd then
      return false
    end
    local found = false
    for line in fd:lines() do
      -- strip trailing comments and whitespace (also handles CRLF)
      if vim.trim((line:gsub("#.*$", ""))) == section then
        found = true
        break
      end
    end
    fd:close()
    return found
  end

  local sections = {}
  local filenames = {}
  for _, marker in ipairs(markers) do
    sections[marker.file] = marker.section
    filenames[#filenames + 1] = marker.file
  end

  -- Don't look for workspaces above the repository root
  local repo = vim.fs.root(path, { ".git", "_darcs", ".hg", ".bzr", ".svn" })

  -- `vim.fs.find` returns nearest matches first, so the last match wins
  local root
  for _, file in ipairs(vim.fs.find(filenames, { path = path, upward = true, type = "file", limit = math.huge })) do
    local dir = vim.fs.dirname(file)
    if
      (not repo or dir == repo or vim.startswith(dir, repo .. "/"))
      and has_section(file, sections[vim.fs.basename(file)])
    then
      root = dir
    end
  end

  return root and { root } or {}
end

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
        neovide_cursor_animate_command_line = true,
        neovide_far_scroll_lines = 200,
        neovide_floating_shadow = true,
        neovide_floating_z_height = 10,
        neovide_floating_corner_radius = 0.4,
        neovide_light_angle_degrees = 45,
        neovide_light_radius = 6,
        neovide_opacity = 0.85,
        neovide_floating_blur_amount_x = 5.0,
        neovide_floating_blur_amount_y = 5.0,

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
        ["<C-S-V>"] = { "<C-\\><C-n>pi", desc = "Paste from clipboard" },
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
        workspace_root,
        "lsp",
        { "init.lua", "Makefile", "package.json", "Cargo.toml", "CMakeLists.txt", "pyproject.toml" },
        { ".git", "_darcs", ".hg", ".bzr", ".svn" },
      },
      autochdir = true,
      scope = "global",
      notify = true,
    },
  },
}
