require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" }
})

require("lspconfig").lua_ls.setup{
    on_attach = function(_,_)
        local keymap = vim.keymap.set
        keymap('n', '<leader>rn', vim.lsp.buf.rename, {})
        keymap('n', '<leader>gd', vim.lsp.buf.definition, {})
        keymap('n', '<leader>gi', vim.lsp.buf.implementation, {})
        keymap('n', '<leader>gr', require('telescope.builtin').lsp_references, {})
        keymap('n', 'K', vim.lsp.buf.hover, {})
    end
}

require("lspconfig").pyright.setup{}
require("lspconfig").tsserver.setup{}
require("lspconfig").yamlls.setup{}
