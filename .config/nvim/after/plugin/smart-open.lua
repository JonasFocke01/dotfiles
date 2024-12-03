vim.keymap.set("n", "<leader>e", function()
    require("telescope").extensions.smart_open.smart_open({
        cwd_only = true,
    })
end)
