return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { { 'filename', path = 1 } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'mode' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_z = { 'location' }
      },
      extensions = { 'nvim-tree' }
    }
  end
}
