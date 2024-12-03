local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.skip_server_setup({ 'rust-analyzer' })

-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


local cmp_mappings = lsp.defaults.cmp_mappings({
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '✗',
        warn  = '❚',
        hint  = '?',
        info  = 'I'
    }
})

lsp.on_attach(function(_, bufnr)
    default_lsp_keybindings(bufnr)
end)

lsp.setup()

require("rust-tools").setup({
    server = {
        on_attach = function(_, bufnr)
            default_lsp_keybindings(bufnr)
        end,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
                inlayHints = {
                    chainingHints = { enable = false },
                    closingBraceHints = { enable = false },
                    parameterHints = { enable = false },
                    typeHints = { enable = false },
                    renderColons = false
                }
            },
        },
    },
})

function default_lsp_keybindings(bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
end
