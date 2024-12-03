require('lazy').setup({
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    "nvim-treesitter/nvim-treesitter",

    "nvim-treesitter/playground",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "nvim-treesitter/nvim-treesitter-context",

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    },

    "eandrju/cellular-automaton.nvim",
    'neovim/nvim-lspconfig',
    'simrat39/rust-tools.nvim',
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        "utilyre/barbecue.nvim",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("barbecue").setup()
        end,
    },

    {
        'fei6409/log-highlight.nvim',
        config = function()
            require('log-highlight').setup {}
        end,
    },

    { 'tmillr/sos.nvim' },

    {
        'j-hui/fidget.nvim',
        version = 'legacy',
        config = function()
            require("fidget").setup {
                -- options
            }
        end,
    },

    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
            }
        end
    },

    'lewis6991/gitsigns.nvim',

    'nvim-lualine/lualine.nvim',

    "f-person/git-blame.nvim",

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },

    {
        'echasnovski/mini.nvim', version = false
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup(
                {
                    throttle = 20,
                    multiple_diag_under_cursor = true,
                    multilines = true,
                    show_all_diags_on_cursorline = true,
                    enable_on_insert = true,
                }
            )
        end
    },

    {
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        config = function()
            require("telescope").load_extension("smart_open")
        end,
        dependencies = {
            "kkharji/sqlite.lua",
            -- Only required if using match_algorithm fzf
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
            { "nvim-telescope/telescope-fzy-native.nvim" },
        },
    },

    {
        'danilamihailov/beacon.nvim'
    },

    {
        'chip/telescope-software-licenses.nvim'
    },

    {
        'nvim-telescope/telescope-symbols.nvim'
    },

    {
        'AckslD/nvim-neoclip.lua',
        dependencies = {
            { 'kkharji/sqlite.lua',           module = 'sqlite' },
            { "nvim-telescope/telescope.nvim" },
        },
    },

    {
        'stevearc/dressing.nvim'
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    }
})
