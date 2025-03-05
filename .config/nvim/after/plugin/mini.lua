local hipatterns = require('mini.hipatterns')
hipatterns.setup({
    highlighters = {
        todo = {
            pattern = '%f[%w]()TODO()%f[%W]',
            group = 'Search'
        },

        hex_color = hipatterns.gen_highlighter.hex_color()

    }
})
local indentscope = require('mini.indentscope')
indentscope.setup({
    draw = {
        delay = 0,
        animation = indentscope.gen_animation.none()
    }
})
local pairs = require('mini.pairs')
pairs.setup()
local map = require('mini.map')
map.setup({
    integrations = {
        map.gen_integration.diff(),
        map.gen_integration.gitsigns(),
        map.gen_integration.diagnostic(),
        map.gen_integration.builtin_search(),
    },
    symbols = {
        encode = map.gen_encode_symbols.dot('3x2'),
    },
    window = {
        show_integration_count = false
    }
})
vim.keymap.set('n', '<Leader>mt', MiniMap.toggle, { desc = 'toggles minimap' })
vim.api.nvim_create_autocmd("VimEnter", { command = "lua MiniMap.open()" })
