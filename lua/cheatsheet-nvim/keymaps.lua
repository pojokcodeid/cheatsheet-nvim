local mode_info = {
  "Mode:",
  " n => normal   i => insert   v => visual   x => visual block   t => terminal",
  "",
}

vim.api.nvim_set_hl(0, "KeymapsSectionOil", { bg = "#8fbcbb", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "KeymapsSectionCmp", { bg = "#b48ead", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "KeymapsSectionComment", { bg = "#bf616a", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Normal2", { bg = "#56B7C3", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color1", { bg = "#D6ACFF", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color2", { bg = "#F1FA8C", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color3", { bg = "#FF79C6", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color4", { bg = "#FF92DF", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color5", { bg = "#69ff94", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color6", { bg = "#FF6E6E", fg = "#1e1e1e", bold = true })
vim.api.nvim_set_hl(0, "Color7", { bg = "#D6ACFF", fg = "#1e1e1e", bold = true })

local section_hl = {
  "KeymapsSectionOil",
  "KeymapsSectionCmp",
  "KeymapsSectionComment",
  "Normal2",
  "Color1",
  "Color2",
  "Color3",
  "Color4",
  "Color5",
  "Color6",
  "Color7",
}

local function pad(str, width)
  local n = vim.fn.strdisplaywidth(str)
  return str .. string.rep(" ", width - n)
end

local function calc_widths(tbl)
  local col1, col2, col3 = 0, 0, 0
  for _, group in pairs(tbl) do
    for _, row in ipairs(group) do
      col1 = math.max(col1, vim.fn.strdisplaywidth(row[1]))
      col2 = math.max(col2, vim.fn.strdisplaywidth(row[2]))
      col3 = math.max(col3, vim.fn.strdisplaywidth(row[3]))
    end
  end
  return col1, col2, col3
end

local function make_lines(tbl, max_width)
  local col1, col2, col3 = calc_widths(tbl)
  if max_width then
    local want = col1 + col2 + col3 + 6
    local padding = max_width - want
    if padding > 0 then
      col1 = col1 + math.floor(padding * 0.8)
      col3 = col3 + (padding - math.floor(padding * 0.8))
    end
  end
  local lines = {}
  local hls = {}

  -- Tambahkan info mode di bagian atas
  for _, info in ipairs(mode_info) do
    table.insert(lines, info)
    table.insert(hls, {})
  end

  local random_index = 1

  -- Urutkan section secara alfabetis
  local section_names = {}
  for section in pairs(tbl) do
    table.insert(section_names, section)
  end
  table.sort(section_names)

  for _, section in ipairs(section_names) do
    local rows = tbl[section]
    local section_title = ("  %s  "):format(section)
    table.insert(lines, section_title)
    table.insert(hls, { { 0, #section_title, section_hl[random_index] or "Normal2" } })
    random_index = random_index + 1
    if random_index > #section_hl then
      random_index = 1
    end

    table.insert(
      lines,
      string.rep("─", col1) .. "─┬─" .. string.rep("─", col2) .. "─┬─" .. string.rep("─", col3)
    )
    table.insert(hls, {})
    for _, row in ipairs(rows) do
      table.insert(lines, pad(row[1], col1) .. " │ " .. pad(row[2], col2) .. " │ " .. pad(row[3], col3))
      table.insert(hls, {})
    end
    table.insert(lines, "")
    table.insert(hls, {})
  end
  return lines, col1 + col2 + col3 + 6, hls
end

local function show_keymaps_popup(key)
  local ui = vim.api.nvim_list_uis()[1]
  local win_width = math.floor(ui.width * 0.8)
  local lines, width, hls = make_lines(key, win_width)
  width = win_width
  local height = #lines

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  -- Set the buffer's filetype to 'keymaps_table'
  vim.api.nvim_buf_set_option(buf, "filetype", "keymaps_table")

  -- highlight section titles
  for i, l in ipairs(hls) do
    for _, v in ipairs(l) do
      vim.api.nvim_buf_add_highlight(buf, -1, v[3], i - 1, v[1], v[2])
    end
  end

  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
    title = "Keymaps",
    title_pos = "center",
  })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true })
  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true })
end

return {
  show = show_keymaps_popup,
}
