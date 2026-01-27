local map = vim.api.nvim_set_keymap

-- move to start/end of line
map('n', '<C-h>', '^', { noremap = true, silent = true })
map('n', '<C-;>', '$', { noremap = true, silent = true })
map('v', '<C-h>', '^', { noremap = true, silent = true })
map('v', '<C-;>', '$', { noremap = true, silent = true })

-- move to start/end of line (Shift version)
map('n', '<S-H>', '^', { noremap = true, silent = true })
map('n', '<S-L>', '$', { noremap = true, silent = true })
map('v', '<S-H>', '^', { noremap = true, silent = true })
map('v', '<S-L>', '$', { noremap = true, silent = true })

-- jj to escape insert mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- comment out (Cmd + /)
map('n', '<D-/>', 'gcc', { noremap = false })
map('v', '<D-/>', 'gc', { noremap = false })
