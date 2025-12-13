return {
  "nvim-lspconfig",
  event = "BufRead",
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-cmp",
  },
  config = function()
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
      setKeymap('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
      setKeymap('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
      setKeymap('n', 'gr', vim.lsp.buf.references, bufopts)
      setKeymap('n', '<leader>f', vim.lsp.buf.format, bufopts)
      setKeymap("n", "[d", vim.diagnostic.goto_prev, bufopts)
      setKeymap("n", "]d", vim.diagnostic.goto_next, bufopts)
    end

    local capabilities = require('cmp_nvim_lsp').default_capabilities() 

    require('mason-lspconfig').setup({
        -- List the servers you want Mason to ensure are installed
        ensure_installed = { "lua_ls", "tsserver", "rust_analyzer" }, -- Add your main LSPs here

        -- This callback runs for every installed server found by mason
        -- and automatically passes it to lspconfig.setup.
        handlers = {
            -- The default handler sets up all servers installed via Mason
            -- using the capabilities and on_attach we provide.
            function(server_name)
                require('lspconfig')[server_name].setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                }
            end,

            -- Dedicated handler for OmniSharp (if needed)
            ["omnisharp"] = function()
                require('lspconfig').omnisharp.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    -- Your specific OmniSharp command arguments
                    cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
                })
            end,
        },
    })
  end
}
