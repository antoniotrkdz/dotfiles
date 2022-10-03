"_______________________________________________________________________________
"________________________________________________/\\\___________________________
"____________________________/\\\________________\/\\\__________________________
"____/\\\____________________\/\\\________________\/\\\_________________________
"__/\\\\\\\\\\\__/\\/\\\\\\\__\/\\\\\\\\___________\/\\\___/\\\\\\\\\\\_________
"__\////\\\////__\/\\\/////\\\_\/\\\////\\\____/\\\\\\\\\__\///////\\\/_________
"______\/\\\______\/\\\___\///__\/\\\\\\\\/____/\\\////\\\_______/\\\/__________
"_______\/\\\_/\\__\/\\\_________\/\\\///\\\___\/\\\__\/\\\_____/\\\/___________
"________\//\\\\\___\/\\\_________\/\\\_\///\\\_\//\\\\\\\/\\__/\\\\\\\\\\\_____
"__________\/////____\///__________\///____\///___\///////\//__\///////////_____
"_______________________________________________________________________________
" 
" ╦  ╔╗╔  ╦  ╔╦╗      ╦  ╦  ╦  ╔╦╗                                            
" ║  ║║║  ║   ║   ┌┐  ╚╗╔╝  ║  ║║║                                            
" ╩  ╝╚╝  ╩   ╩   └┘   ╚╝   ╩  ╩ ╩══════════════════════════════════════════════

" ┬  ┬┬┌┬┐   ┌─┐┬  ┬ ┬┌─┐  ┌─┐┌─┐┌┬┐┬ ┬┌─┐
" └┐┌┘││││───├─┘│  │ ││ ┬  └─┐├┤  │ │ │├─┘
"  └┘ ┴┴ ┴   ┴  ┴─┘└─┘└─┘  └─┘└─┘ ┴ └─┘┴  
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
let curl_exists=expand('curl')

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . "
        \ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  " autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"-- end vim-plug setup ---------------------------------------------------------

set nocompatible

" ╔═╗  ╦    ╦ ╦  ╔═╗  ╦  ╔╗╔  ╔═╗
" ╠═╝  ║    ║ ║  ║ ╦  ║  ║║║  ╚═╗
" ╩    ╩═╝  ╚═╝  ╚═╝  ╩  ╝╚╝  ╚═╝
" Set the runtime path to include Vundle and initialise
call plug#begin('~/.config/nvim/plugged')

" LSP / Completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/cmp-cmdline', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}

" For vsnip users.
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'

" For luasnip users.
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'

" For snippy users.
" Plug 'dcampos/nvim-snippy'
" Plug 'dcampos/cmp-snippy'

" For ultisnips users.
" Code snippets
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'honza/vim-snippets'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" File explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
:lua << EOF
  require'nvim-tree'.setup()
EOF

" Status line
" Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}
Plug 'nvim-lualine/lualine.nvim'

" Debugging
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'mfussenegger/nvim-dap'
" https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/

" Github integration
Plug 'pwntester/octo.nvim'
Plug 'tpope/vim-fugitive'

"Commenter
Plug 'tpope/vim-commentary'

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

"i3wm .config syntax
Plug 'PotatoesMaster/i3-vim-syntax'

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

" Disable all error bells
set belloff=all

" Line number and relative line number
set number
set relativenumber
set ruler

" Show the command as it's being typed
set showcmd

" Shares the system clipboard
set clipboard=unnamed,unnamedplus

" Set n line(s) to be always shown below or above the cursor
set scrolloff=999

" Set to split always right
set splitright

"Set some 'sensible' defaults
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set backspace=indent,eol,start
set complete-=i
"set list! -- see mappings
set listchars=tab:▸\ ,eol:¬,trail:·,space:·

" Since Neovim 0.4.x wildmenu uses pum
" Default wildoptions are set to 'pum,tagfile'
" To get the old wildmenu remove 'pum'
set wildoptions=tagfile

"Avoid showing the mode on the last line
set noshowmode

" Searching
set ignorecase smartcase
"set incsearch "handled by <leader>i -- see mappings
" Use the silversearcher-ag to perform searches (like ack, but faster) 
set grepprg=ag\ -i

" Enable syntax
syntax enable

" Enable filetype-specific plugins and indenting
filetype plugin indent on

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
" Also affects Git Gutter update.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Give more space for displaying messages.
set cmdheight=2

" set completeopt=menu,menuone,noselect "cmp
set completeopt=menuone,noinsert,noselect
set smartindent

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

" ╦    ╔═╗  ╔═╗
" ║    ╚═╗  ╠═╝
" ╩═╝  ╚═╝  ╩  
:lua << EOF
  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    require'completion'.on_attach(client, bufnr)
    protocol.CompletionItemKind = {
        '', -- Text
        '', -- Method
        '', -- Function
        '', -- Constructor
        '', -- Field
        '', -- Variable
        '', -- Class
        'ﰮ', -- Interface
        '', -- Module
        '', -- Property
        '', -- Unit
        '', -- Value
        '', -- Enum
        '', -- Keyword
        '﬌', -- Snippet
        '', -- Color
        '', -- File
        '', -- Reference
        '', -- Folder
        '', -- EnumMember
        '', -- Constant
        '', -- Struct
        '', -- Event
        'ﬦ', -- Operator
        '', -- TypeParameter
      }

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
        vim.api.nvim_exec([[
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

  -- local servers = {'tsserver'}
  -- for _, lsp in ipairs(servers) do
    -- nvim_lsp[lsp].setup {
      -- on_attach = on_attach,
      -- filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 
        --     \ 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
      -- root_dir = function() return vim.loop.cwd() end -- run lsp for javascript in any directory
    -- }
  -- end

  require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
  --  flags = lsp_flags,
  }

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

" Completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

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
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
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

" ╔╦╗  ╔═╗  ╔═╗  ╔═╗  ╦  ╔╗╔  ╔═╗  ╔═╗
" ║║║  ╠═╣  ╠═╝  ╠═╝  ║  ║║║  ║ ╦  ╚═╗
" ╩ ╩  ╩ ╩  ╩    ╩    ╩  ╝╚╝  ╚═╝  ╚═╝
" make sure there are no spaces at the end!
inoremap jk <esc>
inoremap kj <esc>
vnoremap v <esc>
nnoremap H ^
nnoremap L $
nnoremap <C-s> :write<CR>
inoremap <C-s> <esc>:write<CR>i
" noremap <F4> :ALEFix<CR>
noremap <S-A-f> :Format<CR>
" Open the current file in default browser
nnoremap <F5> :execute '!sensible-browser % &'<CR>
" Edit vimrc with f5 and source it with f6
nnoremap <silent> <leader><f5> :e $MYVIMRC<CR>
nnoremap <leader><f6> :so $MYVIMRC<CR>
" Search the word under the cursor in file folder.
noremap <F7> :execute "grep! " . expand("<cword>") . "\| copen"<CR>
noremap <F8> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
" Shortcut to rapidly toggle `set list` = see non printable characters.
nnoremap <leader>l :set list!<CR>
" Turn on/off incremental search (search as you type)
nnoremap <leader>i :set incsearch!<CR>
" Toggle highlighting of search results.
nnoremap <Leader><CR> :set hlsearch!<CR>
" Matchtagalways motion
nnoremap <leader>t :MtaJumpToOtherTag<cr>
" Shortcuts to cicle through the buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
" Shortcuts to cicle through the quickfix results
nnoremap <A-x> :cnext<CR>
nnoremap <A-z> :cprevious<CR>
" Livedow markdown previewer toggle on/off
nnoremap <F6> :LivedownToggle<CR>
" Toggles_highlight of matchit results, for all matching pairs
" that are NOT Parens: (),[],{}; ie.: 'def|class|while|do' with 'end'.
" Toggle off to get tpope/endwise plugin do its job.
nnoremap <leader>p :call Toggle_Extra_Paren_HL()<CR>
" Needed for vim-markbar
" map <Leader>m <Plug>ToggleMarkbar
" Marksigns
let g:marksigns_plugs = 1
map <Leader>m <Plug>(MarksAll)
" surround by quotes - frequently use cases of vim-surround
map <leader>" ysiw"
map <leader>' ysiw'
" Make Y Act like D and C
nnoremap Y y$
" indent without kill the selection in vmode
vmap < <gv
vmap > >gv
" remap the annoying u in visual mode
vmap u y
" shortcut to substitute current word under cursor
nnoremap <leader>s :%s/<c-r><c-w>//gc<left><left><left>

" Open a terminal on the bottom
noremap <F12> :botright 13sp term://$SHELL<CR>i
" mappings to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

nnoremap <silent> <F3> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus and NvimTreeResize are also available if you need them

"  ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗
" ██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
" ██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗
" ██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║
" ╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║
"  ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
  "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
  "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
  "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
  if (empty($TMUX))
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
set background=dark

" VS Code dark theme
let g:vscode_style = "dark"

" Set the theme.
colorscheme vscode
"colorscheme Iosvkem

" Italic for comments.
highlight Comment cterm=italic gui=italic

" Highlight for the matching parenthesis.
highlight MatchParen guibg=NONE guifg=#00ff00 gui=bold

" Highlight for the trailing space
" highlight ExtraWhitespace ctermbg=red guibg=#ff0000
" autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" TODO: highlight off for thr popupmenu
"if (!pumvisible())
"...
"endif

" Highlight past the 80th column
set colorcolumn=81
highlight ColorColumn ctermbg=52 guibg=#302222

" Hide ~ at the end of the buffer
highlight EndOfBuffer ctermfg=NONE guifg=BG

" Iovskem theme fixes (#1bid1e theme bg color, 234 cterm bg)
if g:colors_name=='Iosvkem'
  " Fix ALE signs highlight 
  hi ALEErrorSign cterm=bold ctermfg=203 gui=bold guifg=#ff2040
  hi ALEWarningSign cterm=bold ctermfg=220 gui=bold guifg=#fcbb20
  " Fix git-gutter highlight
  hi GitGutterChange ctermfg=220 guifg=#fcbb20
endif

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guifg=#B079AC

" ╔╗   ╔═╗  ╔═╗  ╦╔═  ╦ ╦  ╔═╗
" ╠╩╗  ╠═╣  ║    ╠╩╗  ║ ║  ╠═╝
" ╚═╝  ╩ ╩  ╚═╝  ╩ ╩  ╚═╝  ╩  
" The // at the end of the path means that the directory information
" will be saved in the filename. 
" For example, the backup file for /home/wtf/Projects/README.md
" will be /path/%home%wtf%Projects%README.md
"
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
