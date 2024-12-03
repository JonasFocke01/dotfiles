local neoclip = require('neoclip')
neoclip.setup()
neoclip.start()
require('telescope').load_extension('neoclip');
vim.keymap.set('n', '<Leader>py', '<cmd>Telescope neoclip<CR>', { desc = 'opens yank history' })
