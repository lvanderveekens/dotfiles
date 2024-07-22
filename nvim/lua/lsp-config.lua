local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.kotlin_language_server.setup{
  capabilities = lsp_capabilities,
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    vim.api.nvim_set_keymap("n", "gd",  "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "gD",  "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "grn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "gi",  "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "gt",  "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "gr",  "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "gs",  "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<A-CR>",  "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
  end,
})


local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-Space>'] = cmp.mapping.complete(),
  })
})
