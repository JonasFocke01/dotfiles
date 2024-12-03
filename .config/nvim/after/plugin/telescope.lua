local telescope = require('telescope')
telescope.setup {
    defaults = {
        layout_strategy = 'vertical',
        initial_mode = 'insert'
    }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>s', builtin.git_files, {})
vim.keymap.set('n', '<leader>d', builtin.live_grep, {})
vim.keymap.set('n', '<leader>xx', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>c', builtin.resume, {})
vim.keymap.set('n', '<leader>gsw', function()
    vim.cmd.Git('fetch')
    builtin.git_branches()
end, {})
vim.keymap.set('v', '<leader>d', function()
    vim.cmd('noau normal! "ky"')

    local text = vim.fn.getreg('k')

    if not text:find("\n") then
        builtin.live_grep({ default_text = text })
    else
        telescope.setup { defaults = { initial_mode = 'normal' } }
        builtin.live_grep({ default_text = string.sub(text, 0, string.find(text, "\n", 1, true) - 1) });
        telescope.setup { defaults = { initial_mode = 'insert' } }
    end
end, {})
