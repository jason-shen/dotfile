local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.init_lsp_saga({
  code_action_lightbulb = {
    enable = true,
    enable_in_insert = true,
    cache_code_action = true,
    sign = true,
    update_time = 150,
    sign_priority = 20,
    virtual_text = true,
},
-- show outline
show_outline = {
  win_position = 'right',
  --set special filetype win that outline window split.like NvimTree neotree
  -- defx, db_ui
  win_with = '',
  win_width = 30,
  auto_enter = true,
  auto_preview = true,
  virt_text = '┃',
  jump_key = 'o',
  -- auto refresh when change buffer
  auto_refresh = true,
},
server_filetype_map = {
  typescript = {'typescript'},
  javascript = {'javascript'},
  gopls = {'go'},
}
})

local opts = { noremap = true, silent = true }
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua require'lspsaga.diagnostic'.show_line_diagnostics()]]
vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("i", "<C-h>", "<Cmd>Lspsaga signature_help<CR>", opts)
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "ca", "<Cmd>Lspsaga code_action<CR>", opts)
-- Outline
vim.keymap.set("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })
