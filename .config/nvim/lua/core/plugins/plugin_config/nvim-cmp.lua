local cmp = require('cmp')
local lspkind = require('lspkind')
local icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

vim.o.completeopt = 'menuone,noselect'

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local luasnip = require('luasnip')
cmp.setup {
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50
      })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s",
        { trimempty = true })

      kind.kind = "[" .. (strings[1] or "") .. "]"
      kind.menu = (icons[strings[2]] or "") .. " " .. (strings[2] or "")
      return kind
    end
  },
  mapping = {
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<CR>'] = cmp.mapping.confirm({
      select = true
    }),
    ["<C-l>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close()
    }
  },
  sources = { { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'codeium' } },
  window = {
    completion = cmp.config.window.bordered({
      border = "rounded",
    }),
    documentation = cmp.config.window.bordered({
      border = "rounded"
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  }
}
