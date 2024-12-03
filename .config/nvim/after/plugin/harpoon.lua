local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>+", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader><leader>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>l", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>k", function() harpoon:list():next() end)
