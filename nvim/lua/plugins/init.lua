return {
    -- Telescope + dependency
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 
            "nvim-lua/plenary.nvim" ,
            "nvim-tree/nvim-web-devicons", 
        },
        config = function()
            require("telescope").setup({})
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        lazy = false, -- neo-tree will lazily load itself
        ---@module "neo-tree"
        ---@type neotree.Config?
        opts = {
            -- fill any relevant options here
        },
    },

    {
        'nvim-telescope/telescope-project.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
    },
    { 
        -- Requires patched nerd font https://www.nerdfonts.com/
        "nvim-tree/nvim-web-devicons", 
        opts = {} 
    },
    {
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            -- Setup orgmode
            require('orgmode').setup({
              org_agenda_files = '~/orgfiles/**/*',
              org_default_notes_file = '~/orgfiles/refile.org',
            })
    
            -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
            -- add ~org~ to ignore_install
            -- require('nvim-treesitter.configs').setup({
            --   ensure_installed = 'all',
            --   ignore_install = { 'org' },
            -- })
        end,
    },
    { 
        "ellisonleao/gruvbox.nvim",
        priority = 1000, -- ensure it loads before you set the colorscheme
        config = function()
            vim.cmd.colorscheme('gruvbox')
        end
    },
}
