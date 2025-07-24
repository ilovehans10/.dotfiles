-- shortenings of some vim functions
local keyset = vim.keymap.set
local option = vim.opt

-- set mapleaders for mappings
vim.g.mapleader = " "
vim.g.maplocalleader = ","
-- set variable for vimrc location
vim.g.vimrc = vim.fn.resolve(vim.fn.expand("<sfile>:p"))

-- many of my options (TODO sort)
option.foldminlines = 5
option.foldnestmax = 3
option.foldenable = false
option.cursorline = true -- highlight the cursorline based on cursorlineopt
option.cursorlineopt = "number" -- highlight the linenumber of the cursorline
option.completeopt = { "menu", "menuone", "noselect" } -- show selection menus
option.encoding = "utf-8" -- set default file encoding
option.backspace = { "indent", "eol", "start" } -- enable all backspacing in insert mode
option.relativenumber = true -- show the line numbers relative to the cursor
option.number = true -- show the line number of the cursor relative to the file
option.wildmenu = true -- show options for commands
option.timeout = true -- don't wait forever for keys that are part of remaps
option.timeoutlen = 1000 -- wait for 1 second for the next key in a remap
option.ttimeoutlen = 100 -- wait for .1 seconds for key escape codes to be typed eg. <Right> = ^[[C
option.expandtab = true -- expand tabs into spaces
option.tabstop = 2 -- number of spaces tab counts for
option.shiftwidth = 0 -- makes shiftwidth match tabstop
option.scrolloff = 5 -- number of lines to keep the cursor from the edges
option.linebreak = true -- makes long lines wrap at characters in breakat
option.mouse = "a" -- allow for all mouse functionality
option.directory = { ".", "~/tmp", "/var/tmp", "/tmp" } -- swapfiles are made in the first directory possible
option.splitbelow = true -- open horizontal splits on the bottom
option.splitright = true -- open vertical splits on the right
option.undofile = true -- keep a history of modifications to a file for undoing after closing a session
option.ignorecase = true -- ignore case when searching
option.smartcase = true -- unless first letter is capitalized
option.termguicolors = true -- change the method highlighting uses to draw colors
option.nrformats:append({ "alpha" }) -- make incrimenting aphabetic characters possible

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
keyset("t", "<S-space>", "<space>")

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
keyset("n", "<leader>ev", (":tab drop " .. vim.fn.expand("<sfile>:p") .. "<CR>"))
keyset("n", "<leader>ez", "<CMD>tab drop ~/.config/zsh/.zshrc<CR>")
keyset("n", "<leader>ep", "<CMD>tab drop ~/.config/zsh/.zprofile<CR>")
keyset("n", "<leader>et", "<CMD>tab drop ~/.config/zsh/tips<CR>")
keyset("n", "<leader>s", ":sm///g<Left><Left>")
keyset("n", "<leader>S", ":%sm///g<Left><Left>")
keyset("n", "<leader>f", ":%! rustfmt<CR>")
keyset("n", "<leader>z", ":set spell!<CR>")
keyset("n", "<leader>Z", "1z=")
keyset("n", "<leader>h", ':let @/=""<CR>')
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
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.txt",
	group = "helpbuffer",
	command = "if &buftype == 'help' | vert resize 78 | setlocal nonumber norelativenumber signcolumn=no | endif",
})

vim.api.nvim_create_augroup("myterm", {})
vim.api.nvim_create_autocmd(
	"TermOpen",
	{ group = "myterm", command = "vert resize 100 | setlocal nonumber norelativenumber nospell signcolumn=no" }
)
vim.api.nvim_create_autocmd("BufEnter", {
	group = "myterm",
	command = "if getwininfo(gettabinfo()[tabpagenr()-1]['windows'][(winnr()-1)])[0]['terminal'] | setlocal nonumber norelativenumber signcolumn=no| startinsert | else | stopinsert | endif",
})

vim.api.nvim_create_augroup("trailingwhitespace", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "trailingwhitespace",
	command = [[ let save_view = winsaveview() | %s/\s\+$//e | call winrestview(save_view) ]],
})

vim.api.nvim_create_augroup("setshiftwidth", {})
vim.api.nvim_create_autocmd(
	"Filetype",
	{ pattern = "*.py", group = "setshiftwidth", command = [[ setlocal shiftwidth=2 ]] }
)

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
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"echasnovski/mini.nvim", -- show git information in the left gutter
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = { add = "+", change = "~", delete = "-" },
				},
			})
			require("mini.indentscope").setup()
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"easymotion/vim-easymotion", -- easymotion allows for smarter movement
		event = "VeryLazy",
	},
	{
		"tpope/vim-surround",
		event = "VeryLazy",
	},
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here.
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by blink.cmp
			"saghen/blink.cmp",
		},
		config = function()
			-- Brief aside: **What is LSP?**
			--
			-- LSP is an initialism you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.
			--
			-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
			-- and elegantly composed help section, `:help lsp-vs-treesitter`

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

					-- Find references for the word under your cursor.
					map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`ts_ls`) will work just fine
				-- ts_ls = {},
				--

				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- lua formatting
				"eslint", -- javascript completions
				"shellcheck", -- bash completions
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
			},
		},
	},

	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
				opts = {},
			},
			"folke/lazydev.nvim",
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			cmdline = {
				completion = {
					menu = { auto_show = true },
					list = { selection = { preselect = false } },
				},
			},
			keymap = { preset = "enter" },
			appearance = { nerd_font_variant = "mono" },
			completion = {
				list = { selection = { preselect = false, auto_insert = true } },
				-- By default, you may press `<c-space>` to show the documentation.
				-- Optionally, set `auto_show = true` to show the documentation after a delay.
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
			},

			sources = {
				default = { "lsp", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},

			snippets = { preset = "luasnip" },

			fuzzy = { implementation = "prefer_rust" },

			-- Shows a signature help window while you type arguments for a function
			signature = { enabled = true },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter", -- generate syntax highlighting based on file
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "bash", "c_sharp", "lua", "nix", "rust", "vimdoc" },
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		config = function()
			keyset("n", "[c", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true })
		end,
	},
	{
		"nvim-lualine/lualine.nvim", -- lua based statusline
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = { "neo-tree" },
						winbar = { "neo-tree" },
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "selectioncount", "searchcount", "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = { "diagnostics" },
					lualine_z = {},
				},
				extensions = {},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim", -- change tab/buffer to hold more information
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "slant",
					indicator = {
						style = "underline",
					},
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							separator = true, -- use a "true" to enable the default, or set your own character
						},
					},
				},
			})
		end,
	},
	{
		"tmsvg/pear-tree", -- add functionality to automatically place closing symbol
		event = "VeryLazy",
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
		end,
	},
	{
		"folke/which-key.nvim", -- shows possible keybinds when a key is pressed
		config = function()
			require("which-key").setup({
				triggers = { { "<auto>", mode = "nixsoc" } },
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim", -- add a vim file explorer
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "\\", "<cmd>Neotree toggle<cr>" },
		},
		config = function()
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
				},
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"mbbill/undotree", -- add an undotree
		keys = {
			{ "|", "<cmd>UndotreeToggle<cr>" },
		},
		config = function()
			vim.g.undotree_WindowLayout = 3
		end,
	},
	{
		"rust-lang/rust.vim",
		event = "VeryLazy",
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
})
