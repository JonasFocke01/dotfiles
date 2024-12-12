vim.keymap.set("n", "<leader><leader>", function()
    require("telescope").extensions.smart_open.smart_open({
        cwd_only = true,
    })
end)
