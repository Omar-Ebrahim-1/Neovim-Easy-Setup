local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pp', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pc', builtin.grep_string, {})
vim.keymap.set('n', '<leader>pr', builtin.registers, {})
vim.keymap.set('n', '<leader>pg', builtin.git_commits, {})
vim.keymap.set('n', '<leader>pb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>pt', builtin.treesitter, {})
-- Need LSP telescope mappings
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, {buffer = 0})

-- Considering removing this
vim.keymap.set('n', '<leader>pn', builtin.keymaps, {})
