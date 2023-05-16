-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
    renderer = { 
        icons = { 
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false,
                modified = false,
            }
        }
    },
    update_focused_file = {
        enable = true,
        update_root = false,
        ignore_list = {},
    },
})


