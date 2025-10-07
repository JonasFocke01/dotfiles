local tab_completions_enabled = true

vim.keymap.set("n", "<leader>au", function()
    if tab_completions_enabled then
        vim.g.augment_disable_completions = true
        tab_completions_enabled = false
    else
        vim.g.augment_disable_completions = false
        tab_completions_enabled = true
    end
end)
