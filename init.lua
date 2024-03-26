-- Good navigation mappings for wrap
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })

-- Window navigation
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { silent = true })

vim.api.nvim_set_keymap('n', '<Space>c', ':bd<CR>', { silent = true })

-- Highlight yanked
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
})


vim.opt.wrap = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.o.termguicolors = true
vim.wo.relativenumber = true  -- Enable relative line numbers
vim.wo.number = true          -- Show the current line number
vim.g.mapleader = ' '

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
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	'm4xshen/autoclose.nvim',
	{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
	{
		"gbprod/substitute.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	},
	'RRethy/base16-nvim',
	{ 'echasnovski/mini.move', version = false },
	{
		'fedepujol/move.nvim',
		opts = {
			--- Config
		}
	},
	{ 'nvim-focus/focus.nvim', version = false },
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"mfussenegger/nvim-dap",
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},
	{
	'nvim-telescope/telescope.nvim', tag = '0.1.6',
	dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
		  "nvim-lua/plenary.nvim",
		  "nvim-tree/nvim-web-devicons",
		  "MunifTanjim/nui.nvim",
		  "3rd/image.nvim",
		}
	},
	{
		'mrcjkb/haskell-tools.nvim',
		version = '^3', -- Recommended
		ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
        "kdheepak/lazygit.nvim",
    	cmd = {
    		"LazyGit",
    		"LazyGitConfig",
    		"LazyGitCurrentFile",
    		"LazyGitFilter",
    		"LazyGitFilterCurrentFile",
    	},
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
           { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		},
		lazy = false,
	}
})

require("autoclose").setup({
   keys = {
      ["$"] = { escape = true, close = true, pair = "$$", disabled_filetypes = {"haskell"} },
   },
})

-- Lua
vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })

require("ibl").setup()
require('move').setup({})
require("focus").setup()

vim.opt.termguicolors = true
require("bufferline").setup{}

local opts = { noremap = true, silent = true }
-- Normal-mode commands
vim.keymap.set('n', '<J>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<K>', ':MoveLine(-1)<CR>', opts)
-- vim.keymap.set('n', '<C-h>', ':MoveHChar(-1)<CR>', opts)
-- vim.keymap.set('n','<C-l>',  ':MoveHChar(1)<CR>', opts)
vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)

-- Visual-mode commands
vim.keymap.set('v', '<J>', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', '<K>', ':MoveBlock(-1)<CR>', opts)
-- vim.keymap.set('v', '<C-h>', ':MoveHBlock(-1)<CR>', opts)
-- vim.keymap.set('v', '<C-l>', ':MoveHBlock(1)<CR>', opts)

local function lsp()
    local clients = vim.lsp.buf_get_clients()
    if next(clients) == nil then
        return
    end

    for _, client in pairs(clients) do
        return("[" .. client.name .. "]")
    end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'base16',
    component_separators = { left = '|', right = '|'},
    -- component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {'neo-tree'},
      winbar = {},
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
    lualine_x = {lsp},
    -- lualine_y = {'progress'},
    lualine_y = {'filetype'},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}



local builtin = require('telescope.builtin')
--vim.keymap.set('n', '<Space>w', ':w<CR>', {})
--vim.keymap.set('n', '<Space>e', ':Neotree toggle<CR>', {})
--vim.keymap.set('n', '<Space>q', ':q<CR>', {})
vim.keymap.set('n', '<Space>ff', builtin.find_files, {})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>fb', builtin.buffers, {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})


-- Define leader key
vim.api.nvim_set_keymap('n', '<Space>w', ':w<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Space>e', ':Neotree toggle<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<Space>f', builtin.find_files, {noremap = true, silent = true})

-- Define leader key followed by 'q' to quit
vim.api.nvim_set_keymap('n', '<Space>q', ':q<CR>', {})


local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)
require'lspconfig'.hls.setup{}
require'lspconfig'.omnisharp.setup{
	cmd = { "/home/fw/.nix-profile/bin/dotnet", "/nix/store/jdp56g0j6mf7yjvqy9npw28y4pxcvgsw-omnisharp-roslyn-1.39.10/lib/omnisharp-roslyn/OmniSharp.dll"},
}
require'lspconfig'.clojure_lsp.setup{}
require'lspconfig'.nil_ls.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.docker_compose_language_service.setup{}
require'lspconfig'.ansiblels.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.lua_ls.setup{}


require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    -- flavour = "auto" -- will respect terminal's background
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
-- vim.cmd.colorscheme "catppuccin"
vim.cmd('colorscheme base16-catppuccin-macchiato')

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<Tab>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

