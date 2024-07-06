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
  setKeymap('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  setKeymap('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  setKeymap('n', 'gr', vim.lsp.buf.references, bufopts)
  setKeymap('n', '<leader>f', vim.lsp.buf.format, bufopts)
  setKeymap("n", "[d", vim.diagnostic.goto_prev, bufopts)
  setKeymap("n", "]d", vim.diagnostic.goto_next, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = require('mason-lspconfig').get_installed_servers()
for _, server in pairs(servers) do
  lsp_config[server].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

local util = require 'lspconfig.util'
local lsp = vim.lsp

local function fix_all(opts)
  opts = opts or {}

  local eslint_lsp_client = util.get_active_client_by_name(opts.bufnr, 'eslint')
  if eslint_lsp_client == nil then
    return
  end

  local request
  if opts.sync then
    request = function(bufnr, method, params)
      eslint_lsp_client.request_sync(method, params, nil, bufnr)
    end
  else
    request = function(bufnr, method, params)
      eslint_lsp_client.request(method, params, nil, bufnr)
    end
  end

  local bufnr = util.validate_bufnr(opts.bufnr or 0)
  request(0, 'workspace/executeCommand', {
    command = 'eslint.applyAllFixes',
    arguments = {
      {
        uri = vim.uri_from_bufnr(bufnr),
        version = lsp.util.buf_versions[bufnr],
      },
    },
  })
end

local root_file = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
}
