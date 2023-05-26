require('gitsigns').setup{
    signs = {
        add = {
            hl = 'GitSignsAdd',
            text = "▎",
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn' },
        change = {
            hl = 'GitSignsChange',
            text = "▎",
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        },
        delete = {
            hl = 'GitSignsDelete',
            text = "契",
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        topdelete = {
            hl = 'GitSignsDelete',
            text = "契",
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        changedelete = {
            hl = 'GitSignsChange',
            text = "▎",
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        }
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = { interval = 1000, follow_files = true },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm = { enable = false }
}


local keymap = vim.keymap.set
keymap('n', "gbl", ":Gitsigns blame_line<CR>", options)
keymap('n', "ghp", ":Gitsigns preview_hunk<CR>", options)
keymap('n', "gnh", ":Gitsigns next_hunk<CR>", options)
keymap('n', "gph", ":Gitsigns prev_hunk<CR>", options)
keymap('n', "gdt", ":Gitsigns diffthis<CR>", options)
keymap('n', "gsh", ":Gitsigns stage_hunk<CR>", options)
keymap('n', "grh", ":Gitsigns reset_hunk<CR>", options)
keymap('n', "grb", ":Gitsigns reset_buffer<CR>", options)
keymap('n', "guh", ":Gitsigns undo_stage_hunk<CR>", options)
keymap('n', "gsb", ":Gitsigns stage_buffer<CR>", options)
