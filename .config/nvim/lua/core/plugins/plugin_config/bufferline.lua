vim.opt.termguicolors = true

require('bufferline').setup({
    options = {
        mode = "buffers", 
        themable = false,
        numbers = "none",
        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15, 
        truncate_names = true, 
        tab_size = 18,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true
            }
        },
        color_icons = true, 
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = false, 
        persist_buffer_sort = true, 
        separator_style = "slant",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        },
        sort_by = 'insert_after_current'
    },
})
