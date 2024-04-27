-- shortenings of some vim functions
local keyset = vim.keymap.set
local option = vim.opt


-- set mapleaders for mappings
vim.g.mapleader = " "
vim.g.maplocalleader = ","
-- set variable for vimrc location
vim.g.vimrc = vim.fn.resolve(vim.fn.expand('<sfile>:p'))


-- many of my options (TODO sort)
option.foldmethod = "expr"
option.foldexpr = "nvim_treesitter#foldexpr()"
option.foldminlines = 10
option.foldnestmax = 3
option.cursorline = true -- highlight the cursorline based on cursorlineopt
option.cursorlineopt = "number" -- highlight the linenumber of the cursorline
option.encoding = "utf-8" -- set default file encoding
option.backspace = {"indent","eol","start"} -- enable all backspacing in insert mode
option.relativenumber = true -- show the line numbers relative to the cursor
option.number = true -- show the line number of the cursor relative to the file
option.wildmenu = true -- show options for commands
option.timeout = true -- don't wait forever for keys that are part of remaps
option.timeoutlen = 1000 -- wait for 1 second for the next key in a remap
option.ttimeoutlen = 100 -- wait for .1 seconds for key escape codes to be typed eg. <Right> = ^[[C
option.expandtab = true -- expand tabs into spaces
option.tabstop = 4 -- number of spaces tab counts for
option.shiftwidth = 4 -- number of spaces to put in place of a tab
option.scrolloff = 5 -- number of lines to keep the cursor from the edges
option.linebreak = true -- makes long lines wrap at characters in breakat
option.mouse = "a" -- allow for all mouse functionality
option.directory = {".", "~/tmp", "/var/tmp", "/tmp"} -- swapfiles are made in the first directory possible
option.splitbelow = true -- open horizontal splits on the bottom
option.splitright = true -- open vertical splits on the right
option.undofile = true -- keep a history of modifications to a file for undoing after closing a session
option.ignorecase = true -- ignore case when searching
option.smartcase = true -- unless first letter is capitalized
option.termguicolors = true -- change the method highlighting uses to draw colors
option.nrformats:append {"alpha"} -- make incrimenting aphabetic characters possible
option.keywordprg =":ShowDocs" -- use :ShowDocs to call show_docs() when K is used to show documentation

-- coc.vim
-- option.hidden = true -- this makes buffers stick around. I am not sure why it is needed so I am testing if it can be removed
option.updatetime = 300 -- after 300 milliseconds write swap to disk
option.signcolumn = "yes" -- show the signcolumn on the left for symbols


-- Fix j and k moving over wrapped lines
keyset("n", "j", "gj")
keyset("n", "k", "gk")

-- Move from window to window with CTRL-movement key
keyset("i", "<C-h>", "<C-\\><C-N><C-w>h")
keyset("i", "<C-j>", "<C-\\><C-N><C-w>j")
keyset("i", "<C-k>", "<C-\\><C-N><C-w>k")
keyset("i", "<C-l>", "<C-\\><C-N><C-w>l")
keyset("n", "<C-h>", "<C-w>h")
keyset("n", "<C-j>", "<C-w>j")
keyset("n", "<C-k>", "<C-w>k")
keyset("n", "<C-l>", "<C-w>l")
keyset("t", "<C-h>", "<C-\\><C-N><C-w>h")
keyset("t", "<C-j>", "<C-\\><C-N><C-w>j")
keyset("t", "<C-k>", "<C-\\><C-N><C-w>k")
keyset("t", "<C-l>", "<C-\\><C-N><C-w>l")

keyset("n", "<ESC><ESC>", ":update<CR>")
keyset("i", "jk", "<ESC>")
keyset("i", "jj", "<ESC>")
keyset("i", "kj", "<ESC>")
keyset("i", "kk", "<ESC>")

-- allow inserting line before/after current
keyset("n", "<leader>j", ":set paste<CR>m`o<ESC>``:set nopaste<CR>") -- insert line after current
keyset("n", "<leader>k", ":set paste<CR>m`O<ESC>``:set nopaste<CR>") -- insert line before current
keyset("n", "<leader>i", "<Plug>IndentGuidesToggle") -- insert line before current
keyset("n", "<leader>w", "g<C-g>") -- show word count for buffer
keyset("v", "<leader>w", "g<C-g>") -- show word count for visual selection
keyset("n", "<leader>ev", (":tab drop " .. vim.fn.expand('<sfile>:p') .. "<CR>"))
keyset("n", "<leader>ez", "<CMD>tab drop ~/.config/zsh/.zshrc<CR>")
keyset("n", "<leader>ep", "<CMD>tab drop ~/.config/zsh/.zprofile<CR>")
keyset("n", "<leader>s", ":s///g<Left><Left>")
keyset("n", "<leader>S", ":%s///g<Left><Left>")
keyset("n", "<leader>f", ":%! rustfmt<CR>")
keyset("n", "<leader>z", ":set spell!<CR>")
keyset("n", "<leader>Z", "1z=")
keyset("n", "<leader>h", ":let @/=\"\"<CR>")
keyset("n", "<leader>H", ":set hlsearch!<CR>")
keyset("n", "<leader>t", ":vsplit term://zsh<CR>")
keyset("n", "<leader>T", ":vert resize 75<CR>")
if vim.v.version >= 910 then
    keyset("ca", "help", "vert help") -- opens help in vertical windows
    keyset("ca", "w!!", "w !sudo tee > /dev/null %") -- allow saving of files with sudo when needed
else
    keyset("c", "w!!", "w !sudo tee > /dev/null %") -- allow saving of files with sudo when needed
end

keyset("t", "<ESC><ESC>", "<C-\\><C-n>")


vim.api.nvim_create_augroup("helpbuffer", {})
vim.api.nvim_create_autocmd( "BufEnter", { pattern = "*.txt", group = "helpbuffer", command = "if &buftype == 'help' | vert resize 78 | setlocal nonumber norelativenumber signcolumn=no | endif" })

vim.api.nvim_create_augroup("myterm", {})
vim.api.nvim_create_autocmd("TermOpen", { group = "myterm", command = "if &buftype ==# 'terminal' | vert resize 100 | endif" })
vim.api.nvim_create_autocmd("BufEnter", { group = "myterm", command = "if &buftype ==# 'terminal' | setlocal nonumber norelativenumber nospell signcolumn=no | startinsert | endif" })

vim.api.nvim_create_augroup("trailingwhitespace", {})
vim.api.nvim_create_autocmd("BufWritePre", { group = "trailingwhitespace", command = [[ let save_view = winsaveview() | %s/\s\+$//e | call winrestview(save_view) ]] })

vim.api.nvim_create_augroup("setshiftwidth", {})
vim.api.nvim_create_autocmd("Filetype", { pattern = "*.py", group = "setshiftwidth", command = [[ setlocal shiftwidth=2 ]] })

vim.api.nvim_create_augroup("changedirectory", {})
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", group = "changedirectory", command = [[ silent! lcd %:p:h ]] })


-- install lazy if it's not found
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
option.rtp:prepend(lazypath)


require("lazy").setup({
    {
        "catppuccin/nvim", -- A pack of catppuccin themes
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin-mocha"
        end
    },
    {
        "wfxr/minimap.vim",
        build = "cargo install --locked code-minimap",
        config = function()
            vim.g.minimap_width = 10
            vim.g.minimap_auto_start = 1
            vim.g.minimap_auto_start_win_enter = 1
        end,

    },
    {
        "airblade/vim-gitgutter", -- show git information in the left gutter
    },
    {
        "preservim/vim-indent-guides", -- color codes indentation levels
        config = function()
            vim.g.indent_guides_enable_on_vim_startup = 1
        end
    },
    {
        "easymotion/vim-easymotion", -- easymotion allows for smarter movement
    },
    {
        "neoclide/coc.nvim", -- coc does completion and snippets
        branch = "release",
        config = function()
            -- set extensions for coc
            vim.g.coc_global_extensions = {"coc-sh", "coc-rust-analyzer", "coc-lua", "coc-pyright", "coc-json", "coc-snippets"}

            -- coc setup
            function _G.check_back_space()
                local col = vim.fn.col(".") - 1
                if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                    return true
                else
                    return false
                end
            end


            -- function that shows documentation based on file type
            function _G.show_docs()
                local cw = vim.fn.expand("<cword>")
                local fname = vim.fn.resolve(vim.fn.expand("%:p"))
                if (vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0) or (vim.g.vimrc == fname) then
                    vim.api.nvim_command("vert h " .. cw)
                elseif vim.api.nvim_eval("coc#rpc#ready()") then
                    vim.fn.CocActionAsync("doHover")
                else
                    vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
                end
            end
            -- vim function that is used by K to show documentation
            vim.cmd("command -nargs=* ShowDocs lua _G.show_docs()")


            vim.api.nvim_create_augroup("CocGroup", {})
            vim.api.nvim_create_autocmd("CursorHold", {
                group = "CocGroup",
                command = "silent call CocActionAsync('highlight')",
                desc = "Highlight symbol under cursor on CursorHold"
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter", -- generate syntax highlighting based on file
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {"lua", "rust", "vimdoc"},
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                }
            }
        end
    },
    {
        'nvim-lualine/lualine.nvim', -- lua based statusline
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {
                        statusline = {'neo-tree'},
                        winbar = {'neo-tree'},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'selectioncount', 'searchcount', 'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {'diagnostics'},
                    lualine_z = {}
                },
                extensions = {}
            }
        end
    },
    {
        'akinsho/bufferline.nvim', -- change tab/buffer to hold more information
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup{
                options = {
                    separator_style = 'slant',
                    indicator = {
                        style = 'underline',
                    },
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            separator = true -- use a "true" to enable the default, or set your own character
                        }
                    },
                }
            }
        end
    },
    {
        "tmsvg/pear-tree", -- add functionality to automatically place closing symbol
        config = function()
            -- disable automatic mapping
            vim.g.pear_tree_map_special_keys = 0

            --mappings
            keyset("i", "<BS>", "<Plug>(PearTreeBackspace)")
            keyset("i", "<Esc>", "<Plug>(PearTreeFinishExpansion)")

            -- Smart pairs are disabled by default:
            vim.g.pear_tree_smart_openers = 1
            vim.g.pear_tree_smart_closers = 1
            vim.g.pear_tree_smart_backspace = 1
        end
    },
    {
        "folke/which-key.nvim", -- shows possible keybinds when a key is pressed
        config = function()
            require("which-key").setup({})
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim", -- add a vim file explorer
        event = "VeryLazy",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function ()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

            -- disable netrw for neotree
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("neo-tree").setup({
                open_files_do_not_replace_types = { "terminal" },
                close_if_last_window = true,
                sources = {
                    "filesystem",
                    "buffers",
                    "git_status",
                    -- "document_symbols", -- I would love to use this but it doesn't work with Coc https://github.com/nvim-neo-tree/neo-tree.nvim/issues/879
                },
                source_selector = {
                    winbar = true, -- toggle to show selector on winbar
                    content_layout = "center",
                    tabs_layout = "equal",
                    show_separator_on_edge = true,
                    sources = {
                        { source = "filesystem", display_name = "󰉓 Files" },
                        { source = "buffers", display_name = "󰈙 Buffers" },
                        { source = "git_status", display_name = " Git" },
                        -- { source = "document_symbols", display_name = " Symbols" },
                    },
                }
            })
        end,
    },
    {
        "mbbill/undotree", -- add an undotree
        config = function()
            vim.g.undotree_WindowLayout = 3
        end,
    },
    {
        "gelguy/wilder.nvim", -- add better commandline/searchline completion
        config = function()
            local wilder = require("wilder")
            wilder.setup({
                modes = {":", "/", "?"}
            })
            wilder.set_option("renderer", wilder.popupmenu_renderer({
                highlighter = wilder.basic_highlighter(),
                left = {" ", wilder.popupmenu_devicons()},
                right = {" ", wilder.popupmenu_scrollbar()},
            }))
        end,
    },
})


-- Plugin Keybindings
keyset("n", "\\", ":Neotree toggle<cr>")
keyset("n", "|", ":UndotreeToggle<cr>")


local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#next(1) : coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : v:lua.check_back_space() ? '<TAB>' : coc#refresh()]], opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<Plug>(PearTreeExpand)"]], opts)

keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
