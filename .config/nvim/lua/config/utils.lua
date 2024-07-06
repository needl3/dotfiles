return {
    keymap = {
        opts = function(desc, bufnr)
            local opts = { noremap = true, silent = true, desc = desc }
            if bufnr then
                opts.buffer = bufnr
            end
            return opts
        end,
    },
    colorscheme = {
        default = "gruvbox",
        select = function()
            vim.ui.select({
                "gruvbox",
            }, { prompt = "Select colorscheme" }, function(choice)
                vim.cmd.colorscheme(choice)
            end)
        end,
    },
    icons = {
        telescope = {
            prompt_prefix = " ",
            selection_caret = " ",
        },
        lspkind = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
        },
    },
}
