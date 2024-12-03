vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local Fugitive = vim.api.nvim_create_augroup("Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = Fugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>p", function()
            local handle = io.popen('git status | grep "rebase in progress" | wc -l')
            local result = handle:read()
            if result == "0" then
                vim.cmd.Git('push')
            else
                vim.cmd.Git("rebase --continue")
            end
            handle:close()
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>gl", function()
            vim.cmd.Git('pull --rebase')
        end, opts)

        vim.keymap.set("n", "<leader>gd", function()
            vim.cmd('vertical Gdiffsplit!')
        end)

        vim.keymap.set("n", "<leader>gl", function()
            vim.cmd('diffget //3')
        end)

        vim.keymap.set("n", "<leader>gh", function()
            vim.cmd('diffget //2')
        end)
    end,
})
