vim.keymap.set("n", "<leader>MIT", function()
    local buffer = vim.api.nvim_get_current_buf();
    local buffer_name = vim.api.nvim_buf_get_name(buffer);
    if string.find(buffer_name, "LICENSE") then
        vim.cmd('Telescope software-licenses find')
    else
        local cwd = vim.fn.getcwd()
        local file_name = cwd .. "/LICENSE"
        local file = io.open(file_name, "w");
        file:write("");
        file:close()
        vim.cmd('edit ' .. file_name)
        vim.cmd('Telescope software-licenses find')
    end
end);
