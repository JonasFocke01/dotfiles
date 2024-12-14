-- set leader
vim.g.mapleader = " "

-- enter netrw
vim.keymap.set("n", "<leader>vv", vim.cmd.Ex)

-- move selected line(s) up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Center on jump up/down/todefinition/next/previous
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>o", "<C-o>zz")
vim.keymap.set("n", "<leader>i", "<C-i>zz")
vim.keymap.set("n", "<gd>", "gdzz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- pasted over lines wont yank into current register
vim.keymap.set("x", "p", [["_dP]])

-- d and s to delete, not cut
vim.keymap.set("x", "d", '"_d')
vim.keymap.set("n", "dd", '"_dd')
vim.keymap.set("n", "s", '"_s')
vim.keymap.set("x", "c", '"_c')


-- Q wont do what it does
vim.keymap.set("n", "Q", "<nop>")

-- format and save
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
    vim.cmd.write()
end)

-- make it rain
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "H", "s<CR><ESC>f ")
