local lsp_config = require("lspconfig")
require("lspconfig.ui.windows").default_options.border = "rounded"
require("mason").setup()

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc',
    'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local setKeymap = vim.keymap.set

  setKeymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
  setKeymap('n', 'gd', vim.lsp.buf.definition, bufopts)
  setKeymap('n', 'K', vim.lsp.buf.hover, bufopts)
  setKeymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
  setKeymap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  setKeymap('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  setKeymap('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  setKeymap('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  setKeymap('n', 'gr', vim.lsp.buf.references, bufopts)
  setKeymap('n', '<space>f', vim.lsp.buf.format, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = require('mason-lspconfig').get_installed_servers()
for _,server in pairs(servers) do
    lsp_config[server].setup{
        on_attach = on_attach,
        capabilities = capabilities
    }
end
