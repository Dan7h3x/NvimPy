vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<F12>', '<Cmd>lua require("stylish").ui_clock()<CR>')
--[[
-- Main
--]]
vim.keymap.set('n', '<C-s>', '<Cmd>w<CR>', { desc = "Saving Command" })
vim.keymap.set('n', '<C-q>', '<Cmd>q!<CR>', { desc = "Exit Command" })
vim.keymap.set('v', '<A-j>', '<Cmd>m .+1<CR>==', { desc = "Move Lines Up" })
vim.keymap.set('v', '<A-k>', '<Cmd>m .-2<CR>==', { desc = "Move Lines Down" })
vim.keymap.set('x', '<A-j>', '<Cmd>move >+1<CR>gv-gv', { desc = "Move Block Up" })
vim.keymap.set('x', '<A-j>', '<Cmd>move <-2<CR>gv-gv', { desc = "Move Block Down" })
-- vim.keymap.set('n','<leader>',)
--[[
-- Telescope
--]]
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Files Finding" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live greping" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Keymaps" })
vim.keymap.set('n', '<leader>fv', builtin.current_buffer_tags, { desc = "Tags in buffer" })
vim.keymap.set('n', '<leader>ft', builtin.colorscheme, { desc = "Themes" })


--[[
-- Ranger
--]]
vim.keymap.set('n', '<leader>fr', '<Cmd>RnvimrToggle<CR>', { desc = "Ranger" })


--[[
-- Neo tree
--]]
vim.keymap.set('n', '<leader>e', '<Cmd>NeoTreeFocusToggle<CR>')


--[[
-- Terminal
--]]
-- vim.keymap.set('n', 't1', '<Cmd>ToggleTerm dir=. direction=horizontal size=45<CR>', { desc = "Terminal horizontal" })
-- vim.keymap.set('n', 't2', '<Cmd>ToggleTerm dir=. direction=vertical size=45<CR>', { desc = "Terminal vertical" })
-- vim.keymap.set('n', 't3', '<Cmd>ToggleTerm dir=.<CR>', { desc = "Terminal" })
