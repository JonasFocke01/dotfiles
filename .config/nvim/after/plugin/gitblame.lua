local git_blame = require('gitblame')
local git_blame_status = false

git_blame.setup {
    enabled = false,
    display_virtual_text = 1,
    date_format = '%r',
    virtual_text_column = 85,
}

vim.keymap.set("n", "<leader>gbb", function()
    git_blame.open_commit_url()
    if git_blame.is_blame_text_available() and git_blame_status then
        print('Opened commit on line ' ..
            vim.fn.line(".") .. ' (' .. git_blame.get_current_blame_text() .. ' ) in browser')
    else
        print('Opened commit on line ' ..
            vim.fn.line(".") .. ' in browser')
    end
end)

vim.keymap.set("n", "<leader>gb", function()
    if git_blame_status then
        git_blame_status = false
    else
        git_blame_status = true
    end
    git_blame.toggle()
end)
