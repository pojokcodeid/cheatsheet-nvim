# CHEATSHEET-NVIM
CHEATSHEET-NVIM is a neovim config to display the keymappings table.
# EXAMPLE
![sample!](img.png)
# CONFIG
```lua
return {
  "pojokcodeid/cheatsheet-nvim",
  event = "VeryLazy",
  keys = {
    { "<F1>", "<cmd>KeymapsPopup<cr>", desc = "Keymaps Popup" },
  },
  cmd = { "KeymapsPopup" },
  opts = {
    ["LSP"] = {
      { "LSP Code Action", "n", "<leader>la" },
      { "LSP Code Format", "n", "<leader>lf" },
      { "LSP Information", "n", "<leader>li" },
      { "Mason Information", "n", "<leader>lI" },
      { "LSP Next Diagnostic", "n", "<leader>lj" },
      { "LSP Previous Diagnostic", "n", "<leader>lk" },
      { "LSP Quickfix", "n", "<leader<lq" },
      { "LSP Rename", "n", "<leader>lr" },
      { "LSP Signature Help", "n", "<leader>ls" },
      { "LSP Format On Range", "v", "<leader>lF" },
    },
    ["Cmp"] = {
      { "Scroll Next Documentation", "i", "CTRL + f" },
      { "Scroll Previous Documentation", "i", "CTRL + b" },
      { "Mapping Complete", "i", "CTRL + space" },
      { "Abort Completion", "i", "CTRL + e" },
      { "Accept Completion", "i", "↵" },
      { "Next Autocompletion", "i", "TAB" },
      { "Previous Autocompletion", "i", "SHIFT + TAB" },
    },
    ["Terminal"] = {
      { "Terminal Float", "n", "<leader>tf" },
      { "Terminal Horizontal", "n", "<leader>th" },
      { "Terminal new tab", "n", "<leader>ts" },
      { "Terminal Vertical", "n", "<leader>tv" },
      { "Terminal Close", "n", "<leader>tx" },
    },
    ["Comment"] = {
      { "Comment line toggle", "n/v", "gcc or CTRL + /" },
      { "Comment block toggle", "n/v", "gbc or CTRL + /" },
      { "Comment visual selection", "v", "gc" },
      { "Comment visual selection using block delimiters", "v", "gb" },
      { "Comment out text object line wise", "v", "gc<motion>" },
      { "Comment out text object block wise", "v", "gb<motion>" },
      { "Add comment on the line above", "n", "gcO" },
      { "Add comment on the line below", "n", "gco" },
      { "Add comment at the end of line", "n", "gcA" },
    },
    ["Bufferline"] = {
      { "Move Active Buffer Left", "n", "SHIFT + h/SHIFT + Left" },
      { "Move Active Buffer Right", "n", "SHIFT + l/SHIFT + Right" },
      { "Reorder Bufferline", "n", "SHIFT + PageUp/PageDown" },
      { "Close Current Buffer", "n", "SHIFT + t" },
    },
    ["Window"] = {
      { "Resize Window", "n", "CTRL + Left/Right/Up/Down" },
      { "Navigate Window", "n", "CTRL + h/l" },
    },
    ["Text-Manipulation"] = {
      { "Select Multiple Cursor Vertical", "n/i", "SHIFT + ALT + Up/Down" },
      { "Select text", "n", "CTRL + d" },
      { "Select Multiple Cursor", "i/n", "ALT + Left Click Mouse" },
      { "Duplicate Row", "i/n/v", "SHIFT + ALT + Up/Down" },
      { "Move Row", "i/n/v", "ALT + Up/Down" },
    },
    ["Ai"] = {
      { "Approve AI Sugention", "i", "CTRL + g" },
      { "Change AI Option", "i", "CTRL + Up/Down" },
      { "Clear AI Sugention", "i", "CTRL + x" },
    },
  },

  config = true,
}
```
# Default Command
```bash
:KeymapsPopup
```