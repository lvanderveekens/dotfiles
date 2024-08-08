-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'

    use {
        "NeogitOrg/neogit",
        requires = { {'nvim-lua/plenary.nvim'} }
    }


    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-jdtls'
    use 'nvim-lua/plenary.nvim'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use "EdenEast/nightfox.nvim"
    use 'folke/tokyonight.nvim'

    use 'stephpy/vim-php-cs-fixer'

    use 'morhetz/gruvbox'

    use 'nvim-treesitter/nvim-treesitter'
    use 'udalov/kotlin-vim'

    use 'lewis6991/gitsigns.nvim'
end)
