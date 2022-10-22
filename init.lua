--[[___________________________________________________________________________
________________________________________________/\\\___________________________
____________________________/\\\________________\/\\\__________________________
____/\\\____________________\/\\\________________\/\\\_________________________
__/\\\\\\\\\\\__/\\/\\\\\\\__\/\\\\\\\\___________\/\\\___/\\\\\\\\\\\_________
__\////\\\////__\/\\\/////\\\_\/\\\////\\\____/\\\\\\\\\__\///////\\\/_________
______\/\\\______\/\\\___\///__\/\\\\\\\\/____/\\\////\\\_______/\\\/__________
_______\/\\\_/\\__\/\\\_________\/\\\///\\\___\/\\\__\/\\\_____/\\\/___________
________\//\\\\\___\/\\\_________\/\\\_\///\\\_\//\\\\\\\/\\__/\\\\\\\\\\\_____
__________\/////____\///__________\///____\///___\///////\//__\///////////_____
_____________________________________________________________________________]]

local g = vim.g
local opt = vim.opt
local api = vim.api

-- disable netrw (nvim-tree)
g.loaded = 1
g.loaded_netrwPlugin = 1

opt.compatible = false
-- Disable all error bells
opt.belloff = 'all'
-- Line number and relative line number
opt.number = true
opt.relativenumber = true
opt.ruler = true

-- Show the command as it's being typed
opt.showcmd = true

-- Shares the system clipboard
opt.clipboard = 'unnamed,unnamedplus'

-- Set n line(s) to be always shown below or above the cursor
opt.scrolloff = 999

-- Set to split always right
opt.splitright = true

-- Set some 'sensible' defaults
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.backspace = { 'indent' , 'eol', 'start' }
--set complete-=i
--set list! -- see mappings
opt.listchars = { tab = '▸ ', eol= '¬', trail = '·', space = '·' }

-- Since Neovim 0.4.x wildmenu uses pum
-- Default wildoptions are set to 'pum,tagfile'
-- To get the old wildmenu remove 'pum'
opt.wildoptions = 'tagfile'

-- Avoid showing the mode on the last line
opt.showmode = false

-- Searching
opt.ignorecase = true
opt.smartcase = true
-- set incsearch "handled by <leader>i -- see mappings
-- Use the silversearcher-ag to perform searches (like ack, but faster) 
opt.grepprg = 'ag -i'

-- Enable syntax
-- Enable filetype-specific plugins and indenting
-- filetype plugin indent on 
-- Theese are enable by default

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
-- Also affects Git Gutter update.
opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
opt.shortmess:append({ c = true })

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
opt.signcolumn = 'yes'

-- Give more space for displaying messages.
opt.cmdheight = 2

-- set completeopt=menu,menuone,noselect -- cmp default 
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
opt.smartindent = true
opt.termguicolors = true
                                                                            --[[
╔═╗  ╦    ╦ ╦  ╔═╗  ╦  ╔╗╔  ╔═╗
╠═╝  ║    ║ ║  ║ ╦  ║  ║║║  ╚═╗
╩    ╩═╝  ╚═╝  ╚═╝  ╩  ╝╚╝  ╚═╝
                                                                              ]]
vim.cmd("packadd packer.nvim")

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Theme
  use 'Mofiqul/vscode.nvim'
  use 'martinsione/darkplus.nvim'

  -- Status line
  use 'nvim-lualine/lualine.nvim'

  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- Git symbols
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  -- i3wm .config syntax
  use 'PotatoesMaster/i3-vim-syntax'

  -- LSP / Completion
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- Ultisnips
  use 'SirVer/ultisnips'
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  -- use 'honza/vim-snippets'
  -- File explorer
  use 'kyazdani42/nvim-web-devicons'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }
  use 'onsails/lspkind.nvim'

  -- Commenter
  -- use 'tpope/vim-commentary'
  use 'terrortylor/nvim-comment' -- Does not have block comment

  use "lukas-reineke/indent-blankline.nvim"

end)

-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require('nvim_comment').setup({comment_empty = false})

-- empty setup using defaults
require("nvim-tree").setup()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "javascript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

--make sure you call this before you set up any servers!
require("mason").setup {}
require("mason-lspconfig").setup({
  ensure_installed = { "sumneko_lua", "tsserver" }
})
                                                                            --[[
╦    ╔═╗  ╔═╗
║    ╚═╗  ╠═╝
╩═╝  ╚═╝  ╩  
                                                                              ]]
local nvim_lsp = require('lspconfig')
local cmp = require'cmp'

local on_attach = function(client, bufnr)
  cmp.on_attach(client, bufnr)

  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap=true, silent=true, buffer=bufnr }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
      api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], false)
  end
end

-- local servers = {'sumneko_lua','tsserver'}
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup {
--     on_attach = on_attach,
--     filetypes = {
--       'javascript',
--       'javascriptreact',
--       'json',
--       'typescript',
--       'typescriptreact',
--       'css',
--       'less',
--       'scss',
--       'markdown',
--       'pandoc'
--     },
--     root_dir = function() return vim.loop.cwd() end -- run lsp for javascript in any directory
--   }
-- end

nvim_lsp['sumneko_lua'].setup{
--  on_attach = on_attach
}

nvim_lsp['tsserver'].setup{
--  on_attach = on_attach,
  filetypes = {
    'javascript',
    'javascriptreact',
    'json',
    'typescript',
    'typescriptreact',
    'css',
    'less',
    'scss',
    'markdown',
    'pandoc'
  },
  root_dir = function() return vim.loop.cwd() end -- run lsp for javascript in any directory
--  flags = lsp_flags,
}

-- Completion
--g.completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
-- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

-- Set up nvim-cmp.
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})


-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['tsserver'].setup {
  capabilities = capabilities
}

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 -- override = {
 --  zsh = {
 --    icon = "",
 --    color = "#428850",
 --    cterm_color = "65",
 --    name = "Zsh"
 --  }
 -- }

 -- From: https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887
 -- '', -- Text
 -- '', -- Method
 -- '', -- Function
 -- '', -- Constructor
 -- '', -- Field
 -- '', -- Variable
 -- '', -- Class
 -- 'ﰮ', -- Interface
 -- '', -- Module
 -- '', -- Property
 -- '', -- Unit
 -- '', -- Value
 -- '', -- Enum
 -- '', -- Keyword
 -- '﬌', -- Snippet
 -- '', -- Color
 -- '', -- File
 -- '', -- Reference
 -- '', -- Folder
 -- '', -- EnumMember
 -- '', -- Constant
 -- '', -- Struct
 -- '', -- Event
 -- 'ﬦ', -- Operator
 -- '', -- TypeParameter

 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

local lspkind = require('lspkind')
-- cmp.setup {
--  formatting = {
--   format = lspkind.cmp_format({
--      mode = 'symbol', -- show only symbol annotations
--      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
--      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
--      before = function (entry, vim_item)
--       ...
--      return vim_item
--      end
--    })
--  }
--}

cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end
      return lspkind.cmp_format({ with_text = false })(entry, vim_item)
    end
  }
}
--[[
" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


" Debugging
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'mfussenegger/nvim-dap'
" https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/

" Github integration
Plug 'pwntester/octo.nvim'
Plug 'tpope/vim-fugitive'

"wisely add 'end' in ruby (maybe bash)
Plug 'tpope/vim-endwise'
"
"Surround - surround or change the surround an item with "''() etc.
Plug 'tpope/vim-surround'

" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

"UNIX shell commands
Plug 'tpope/vim-eunuch'

"Emmet for HTML editing, <c-y> to trigger completion
Plug 'mattn/emmet-vim'

"Colour preview in code
Plug 'ap/vim-css-color'

"Always highlights the enclosing XML/HTML tags 
Plug 'valloric/matchtagalways'

"Doubles quotes and parenthesis on the fly
Plug 'raimondi/delimitmate'

"Asynchronously fly grep (SpaceVim)
Plug 'wsdjeg/FlyGrep.vim'

"Multiple cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"Underlines a word element
Plug 'itchyny/vim-cursorword'

" Much simpler rainbow parentheses
Plug 'junegunn/rainbow_parentheses.vim'

" Easy, <leader><leader>f<letter> you want to move to
Plug 'easymotion/vim-easymotion'

"Markdown editor (git READMEs)
Plug 'shime/vim-livedown'

"Vim-markbar (activate with ' or `)
" Plug 'Yilin-Yang/vim-markbar'

"Alternative sudo.vim for Vim and Neovim
Plug 'lambdalisue/suda.vim'

" Vim syntax highlighting for the OpenSCAD 3D modeling language
" Plug 'sirtaj/vim-openscad'

"Unmanged plugins
" to show terminal colors, use :XtermColorTable 
Plug '~/.vim/xterm-color-table.vim'
" Highlight matchit.
Plug '~/.vim/99-hl-matchlines.vim'
" Uncomplicated alternative to vim-signature (shows mark in gutter)
" Here in place of vim-markbar
Plug '~/.vim/marksigns.vim'

"Themes (CLI)
Plug 'neutaaaaan/iosvkem'
Plug 'Mofiqul/vscode.nvim', {'branch': 'main'}

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" ╔╦╗ ╦ ╔═╗ ╔═╗ ╔═╗ ╦   ╦   ╔═╗ ╔╗╔ ╔═╗ ╔═╗
" ║║║ ║ ╚═╗ ║   ║╣  ║   ║   ╠═╣ ║║║ ║╣  ╠═╣
" ╩ ╩ ╩ ╚═╝ ╚═╝ ╚═╝ ╩═╝ ╩═╝ ╩ ╩ ╝╚╝ ╚═╝ ╩ ╩
" Highlight the current line and column only in the current window
autocmd WinLeave * set nocursorline nocursorcolumn
autocmd WinEnter * set cursorline cursorcolumn
autocmd vimEnter * set cursorline cursorcolumn

" Highlight yanked text
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" Suda.vim prefix
let g:suda#prefix = 'su//'

" DelimitMate config
au FileType html,vim let b:delimitMate_matchpairs = "(:),[:],{:},<:>"

" nnoremap <Space>v :e ~/.config/nvim/init.exp2.vim<CR>


  nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 
          \ 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
    init_options = {
      linters = {
        eslint = {
          command = 'eslint_d',
          rootPatterns = { '.git' },
          debounce = 100,
          args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
          sourceName = 'eslint_d',
          parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '[eslint(standard)] ${message} [${ruleId}]',
            security = 'severity'
          },
          securities = {
            [2] = 'error',
            [1] = 'warning'
          }
        },
        standard = {
          command = 'standard',
          rootPatterns = { '.git' },
          debounce = 100,
          args = { '--stdin', '%filepath' },
          sourceName = 'standard',
          parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '[standard] ${message} [${ruleId}]',
            security = 'severity'
          },
          securities = {
            [2] = 'error',
            [1] = 'warning'
          }
        },
      },
      filetypes = {
        javascript = 'eslint',
        javascriptreact = 'eslint',
        typescript = 'eslint',
        typescriptreact = 'eslint',
      },
      formatters = {
        eslint_d = {
          command = 'eslint_d',
          args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
          rootPatterns = { '.git' }
        },
        standard = {
          command = 'standard',
          args = { '--stdin', '%filename' },
          rootPatterns = { '.git' }
        },
        prettier = {
          command = 'prettier',
          args = { '--stdin-filepath', '%filename' }
        }
      },
      formatFiletypes = {
        css = 'prettier',
        javascript = 'eslint_d',
        javascriptreact = 'eslint_d',
        json = 'prettier',
        scss = 'prettier',
        less = 'prettier',
        typescript = 'eslint_d',
        typescriptreact = 'eslint_d',
        json = 'prettier',
        markdown = 'prettier',
      }
    }
  }
EOF

EOF
" -- LSP ----------------------------------------------------------------------

" Code snippets
let g:completion_enable_snippet = 'UltiSnips'

" Fuzzy finder
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr>

" Syntax
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}
EOF

" File explorer
nnoremap <leader>tt :NvimTreeToggle<CR>
nnoremap <leader>tr :NvimTreeRefresh<CR>
nnoremap <leader>tn :NvimTreeFindFile<CR>
" NvimTreeOpen and NvimTreeClose are also available if you need them

" Status line
" luafile ~/.config/nvim/eviline.lua
" luafile ~/.config/nvim/galaxyline.lua
" luafile ~/.config/nvim/evil_lualine.lua
lua << END
require('lualine').setup {
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  }
}
require('lualine').get_config()
END

" Debugging
lua <<EOF
require('telescope').load_extension('dap')
EOF
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dd :lua require('dap').continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>`
]]
                                                                            --[[
╔╦╗  ╔═╗  ╔═╗  ╔═╗  ╦  ╔╗╔  ╔═╗  ╔═╗
║║║  ╠═╣  ╠═╝  ╠═╝  ║  ║║║  ║ ╦  ╚═╗
╩ ╩  ╩ ╩  ╩    ╩    ╩  ╝╚╝  ╚═╝  ╚═╝
-- make sure there are no spaces at the end!
                                                                              ]]
--local function nrmap(mode, shortcut, command)
--  vim.keymap(m, k, v, { noremap = true, silent = true })
--end
--local function map(mode, shortcut, command)
--  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
--end
-- , silent = true 
api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true})
api.nvim_set_keymap('i', 'kj', '<ESC>', { noremap = true})
api.nvim_set_keymap('v', 'v', '<ESC>', { noremap = true})
api.nvim_set_keymap('n', 'H', '^', { noremap = true})
api.nvim_set_keymap('n', 'L', '$', { noremap = true})
api.nvim_set_keymap('n', '<C-s>', ':write<CR>', { noremap = true})
api.nvim_set_keymap('i', '<C-s>', '<ESC>:write<CR>i', { noremap = true})
-- noremap <F4> :ALEFix<CR>
-- noremap <S-A-f> :Format<CR>
-- Open the current file in default browser
api.nvim_set_keymap('n', '<F5>', ':execute "!sensible-browser % &"<CR>', { noremap = true, silent = true })
-- Edit vimrc with f5 and source it with f6
--myvimrc = vim.env.MYVIMRC
-- function _G.ReloadConfig()
  -- dofile(vim.env.MYVIMRC)
  -- vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
-- end
-- api.nvim_set_keymap('n', '<leader><F6>', '<cmd>lua ReloadConfig()<CR>', { noremap = true, silent = false })
-- api.nvim_set_keymap('n', '<leader><F6>', ':so myvimrc<CR>', { noremap = true })
-- Search the word under the cursor in file folder.
api.nvim_set_keymap('n', '<F7>', ':execute "grep! " . expand("<cword>") . " | copen"<CR>', { noremap = true })
api.nvim_set_keymap('n', '<F8>', ':execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>', { noremap = true })
-- Shortcut to rapidly toggle `set list` = see non printable characters.
api.nvim_set_keymap('n', '<leader>l', ':set list!<CR>', { noremap = true, silent = true })
-- Turn on/off incremental search (search as you type)
api.nvim_set_keymap('n', '<leader>i', ':set incsearch!<CR>', { noremap = true })
-- Toggle highlighting of search results.
api.nvim_set_keymap('n', '<Leader><CR>', ':set hlsearch!<CR>', { noremap = true, silent = true })
-- Matchtagalways motion
api.nvim_set_keymap('n','tt', ':MtaJumpToOtherTag<cr>', { noremap = true, silent = true })
-- Shortcuts to cicle through the buffers
api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })
-- Shortcuts to cicle through the quickfix results
--nnoremap <A-x> :cnext<CR>
--nnoremap <A-z> :cprevious<CR>
-- Livedow markdown previewer toggle on/off
--nnoremap <F6> :LivedownToggle<CR>
-- Toggles_highlight of matchit results, for all matching pairs
-- that are NOT Parens: (),[],{}; ie.: 'def|class|while|do' with 'end'.
-- Toggle off to get tpope/endwise plugin do its job.
--nnoremap <leader>p :call Toggle_Extra_Paren_HL()<CR>
-- Needed for vim-markbar
--map <Leader>m <Plug>ToggleMarkbar
-- Marksigns
-- let g:marksigns_plugs = 1
--map <Leader>m <Plug>(MarksAll)
-- surround by quotes - frequently use cases of vim-surround
api.nvim_set_keymap('n', '<leader>"', 'ysiw"', { noremap = true, silent = true })
api.nvim_set_keymap('n', "<leader>'", "ysiw'", { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>(', 'ysiw(', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>[', 'ysiw[', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>{', 'ysiw{', { noremap = true, silent = true })
-- Make Y Act like D and C
api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true, silent = true })
-- indent without kill the selection in vmode
api.nvim_set_keymap('v', '<', '<gv', { silent = true })
api.nvim_set_keymap('v', '>', '>gv', { silent = true })
-- remap the annoying u in visual mode
api.nvim_set_keymap('v', 'u', 'y', { silent = true })
-- shortcut to substitute current word under cursor
api.nvim_set_keymap('n', '<leader>s', ':%s/<c-r><c-w>//gc<left><left><left>', { noremap = true, silent = true })

-- Open a terminal on the bottom
api.nvim_set_keymap('n', '<F12>', ':botright 13sp term://$SHELL<CR>i', { noremap = true, silent = true })
-- mappings to exit terminal-mode:
api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap = true, silent = true })
api.nvim_set_keymap('t', 'jk', '<C-\\><C-n>', { noremap = true, silent = true })
api.nvim_set_keymap('t', '<kj>', '<C-\\><C-n>', { noremap = true, silent = true })

api.nvim_set_keymap('n', '<F3>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>f', ':NvimTreeFindFile<CR>', { noremap = true })
-- NvimTreeOpen, NvimTreeClose, NvimTreeFocus and NvimTreeResize are also available if you need them

--[[
 ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗
██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗
██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║
╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║
 ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check
and use tmux's 24-bit color support
(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
]]
--[[  if (empty($TMUX))
    if (has("nvim"))
      "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
      set termguicolors
    endif
  endif
  ]]

opt.background = 'dark'

local c = require('vscode.colors')
require('vscode').setup({
    -- Enable transparent background
    -- transparent = true,

    -- Enable italic comment
    -- italic_comments = true,

    -- Disable nvim-tree background color
    -- disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    -- color_overrides = {
        -- vscLineNumber = '#FFFFFF',
    -- },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    -- group_overrides = {
    --     -- this supports the same val table as vim.api.nvim_set_hl
    --     -- use colors from this colorscheme by requiring vscode.colors!
    --     cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    -- }
})

require('lualine').setup {
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    theme = 'vscode',
  }
}

-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

api.nvim_set_hl(0, 'IndentBlanklineIndent1', { fg = "#E06C75", nocombine = true })
api.nvim_set_hl(0, 'IndentBlanklineIndent2', { fg = "#E5C07B", nocombine = true })
api.nvim_set_hl(0, 'IndentBlanklineIndent3', { fg = "#98C379", nocombine = true })
api.nvim_set_hl(0, 'IndentBlanklineIndent4', { fg = "#56B6C2", nocombine = true })
api.nvim_set_hl(0, 'IndentBlanklineIndent5', { fg = "#61AFEF", nocombine = true })
api.nvim_set_hl(0, 'IndentBlanklineIndent6', { fg = "#C678DD", nocombine = true })

require("indent_blankline").setup {
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}

-- VS Code dark theme
-- g.vscode_style = 'dark'

-- Set the theme.
-- vim.cmd[[colorscheme darkplus]]
-- vim.cmd[[colorscheme vscode]]
-- vim.cmd[[colorscheme Iosvkem]]

-- vim.api.nvim_set_hl(0, 'Normal', { fg = "#ffffff", bg = "#333333" })
-- vim.api.nvim_set_hl(0, 'Comment', { fg = "#111111", bold = true })
-- vim.api.nvim_set_hl(0, 'Error', { fg = "#ffffff", undercurl = true })
-- vim.api.nvim_set_hl(0, 'Cursor', { reverse = true })

-- Italic for comments.
-- highlight Comment cterm=italic gui=italic
-- api.nvim_set_hl(0, 'Comment', { italic = true })

api.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        -- api.nvim_set_hl(0, 'IncSearch', { fg = "#aaaa00" })
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 250 })
    end,
})

-- Highlight for the matching parenthesis.
-- highlight MatchParen guibg=NONE guifg=#00ff00 gui=bold

-- Highlight for the trailing space
-- highlight ExtraWhitespace ctermbg=red guibg=#ff0000
-- autocmd Syntax * if (!pumvisible())
-- syn match ExtraWhitespace /\s\+$\| \+\ze\\t/
-- endif

-- Highlight past the 80th column
-- opt.colorcolumn = 81
-- highlight ColorColumn ctermbg=52 guibg=#302222

-- Hide ~ at the end of the buffer
-- highlight EndOfBuffer ctermfg=NONE guifg=BG

-- Iovskem theme fixes (#1bid1e theme bg color, 234 cterm bg)
--[[
if g:colors_name=='Iosvkem'
  " Fix ALE signs highlight 
  hi ALEErrorSign cterm=bold ctermfg=203 gui=bold guifg=#ff2040
  hi ALEWarningSign cterm=bold ctermfg=220 gui=bold guifg=#fcbb20
  " Fix git-gutter highlight
  hi GitGutterChange ctermfg=220 guifg=#fcbb20
endif
]]

-- a list of groups can be found at `:help nvim_tree_highlight`
-- highlight NvimTreeFolderIcon guifg=#B079AC

--[[
╔╗   ╔═╗  ╔═╗  ╦╔═  ╦ ╦  ╔═╗
╠╩╗  ╠═╣  ║    ╠╩╗  ║ ║  ╠═╝
╚═╝  ╩ ╩  ╚═╝  ╩ ╩  ╚═╝  ╩  
The // at the end of the path means that the directory information
will be saved in the filename. 
For example, the backup file for /home/wtf/Projects/README.md
will be /path/%home%wtf%Projects%README.md
]]
--[[
if isdirectory($HOME . '/.config/nvim/backup') == 0
	:silent !mkdir -p ~/.config/nvim/backup >/dev/null 2>&1
endif
set backupdir=~/.config/nvim/backup//
set backupdir+=/tmp//
set backup

" Save your swp files to a less annoying place than the current directory.
" It saves it to ~/.config/nvim/swap, or /tmp
if isdirectory($HOME . '/.config/nvim/swap') == 0
	:silent !mkdir -p ~/.config/nvim/swap >/dev/null 2>&1
endif
set directory=~/.config/nvim/swap//
set directory+=/tmp//

if exists("+undofile")
	" undofile - This allows you to use undos after exiting and restarting
	" This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
	" :help undo-persistence
	if isdirectory($HOME . '/.config/nvim/undo') == 0
		:silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
	endif
	set undodir=~/.config/nvim/undo//
  set directory+=/tmp//
	set undofile
endif
]]
