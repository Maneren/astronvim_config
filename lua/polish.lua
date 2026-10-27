if vim.g.neovide then
  vim.env.TERM = "xterm-256color"
end

-- Enable the experimental ui2
local ui2 = require("vim._core.ui2")
ui2.enable {
  msg = { target = "msg" },
}

-- Workaround for https://github.com/neovim/neovim/issues/39938
-- The "msg_ruler" UI event can fire while a buffer is closing. Creating the
-- message float then fails with E1159, which is reported as a startup error.
-- Skip just that error; a later redraw will create the window normally.
local check_targets = ui2.check_targets
ui2.check_targets = function()
  local ok, err = pcall(check_targets)
  if not ok and not tostring(err):match("E1159") then
    error(err)
  end
end
