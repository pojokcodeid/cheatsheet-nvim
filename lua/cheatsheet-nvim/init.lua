local M = {}

M.setup = function(keymaps)
  vim.api.nvim_create_user_command("KeymapsPopup", function()
    require("cheatsheet-nvim.keymaps").show(keymaps)
  end, {})
end

return M
