-- Load core configurations
require('core.options')

-- Load plugins
require('plugins')

-- Load key mappings
require('core.keymaps')

-- Load plugin configurations
require('plugin_configs.neo-tree')
require('plugin_configs.telescope')
require('plugin_configs.treesitter')
require('plugin_configs.nvim-autopairs')
require('plugin_configs.comment')

-- Keymap for telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>b', ':Neotree toggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tp', ':tabprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tf', ':tabfirst<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tl', ':tablast<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tt', ':tabnew<CR>', { noremap = true, silent = true })

-- Setting up diff
vim.cmd('highlight DiffAdd ctermfg=Green guifg=Green')
vim.cmd('highlight DiffChange ctermfg=Yellow guifg=Yellow')
vim.cmd('highlight DiffDelete ctermfg=Red guifg=Red')
vim.cmd('highlight DiffText ctermfg=Blue guifg=Blue')

-- Set diff options
vim.opt.diffopt:append('vertical')

-- Set colorscheme
vim.cmd('colorscheme github_dark_high_contrast')
