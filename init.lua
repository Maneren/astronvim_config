-- use different font sizes for desktop and laptop
if vim.fn.hostname() == "maneren-pc" then
  vim.opt.guifont = { "Iosevka", ":h14" }
else
  vim.opt.guifont = { "Iosevka", ":h10" }
end
vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_remember_window_size = true
vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animate_command_line = false

vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta) vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta end
vim.keymap.set("n", "<C-=>", function() change_scale_factor(1.1) end)
vim.keymap.set("n", "<C-->", function() change_scale_factor(1 / 1.1) end)

--    AstroNvim Configuration Table
return {
  colorscheme = "catppuccin",
  options = {
    opt = {
      relativenumber = false,
      number = true,
    },
  },
}
