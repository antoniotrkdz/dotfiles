set nocompatible "IMproved, required
"This command makes vim start a file with all folds closed
"set foldlevelstart=0
"-----------------------------------------------------------
"Plugins
"-----------------------------------------------------------{{{
"Autoinstall vim plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"set the runtime path to include Vundle and initialise
call plug#begin('~/.vim/plugged')

"Git wrapper
Plug 'tpope/vim-fugitive'
"Symbols for git changes tracking
Plug 'airblade/vim-gitgutter'
"NERDTree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdcommenter'
"YouCompleteMe + tern completer
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'ternjs/tern_for_vim'
" Ale Async Linting (+formatting) as you type
Plug 'w0rp/ale'
" Autoformat for other files (not js)
Plug 'chiel92/vim-autoformat'
Plug 'pangloss/vim-javascript'
"Added vim snippets for code autofilling
Plug 'SirVer/ultisnips' 
"Emmet for HTML editing
Plug 'mattn/emmet-vim'
"Colour preview in code
Plug 'ap/vim-css-color'
"Airline bottom bar (and top one)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Patched fonts needed to display fancy airline
"Copy the desired font(s) in .local/share/fonts
"set the required font(s) in the console settings
Plug 'powerline/fonts'
"Surround - surround or change the surround an item with "''() etc.
Plug 'tpope/vim-surround'
"Doubles quotes and parenthesis on the fly
Plug 'raimondi/delimitmate'
"UNIX shell commands
Plug 'tpope/vim-eunuch'
"Fuzzy files search (also avialble in bash)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"CtrlP Fuzzy search
Plug 'ctrlpvim/ctrlp.vim'
"Multiple cursors
Plug 'terryma/vim-multiple-cursors'
"Underlines a word element
Plug 'itchyny/vim-cursorword'
"Help for vim in vim
Plug 'lifepillar/vim-cheat40'
"Easy: <leader><leader>f<letter> you want to move to
Plug 'easymotion/vim-easymotion'
"Markdown editor (git READMEs)
Plug 'shime/vim-livedown'
"Database completion
Plug 'vim-scripts/dbext.vim'

"Themes (for GUI and CLI)
Plug 'KeitaNakamura/neodark.vim'
Plug 'desert256.vim'
Plug 'rainux/vim-desert-warm-256'
Plug 'rakr/vim-one'
Plug 'tyrannicaltoucan/vim-quantum'

call plug#end()

"Mappings (make sure there are no spaces at the end!)
"nnoremap <Space> i
inoremap jk <esc>
inoremap kj <esc>
nnoremap <silent> <F2> :NERDTreeTabsToggle<CR>
noremap <F3> :Autoformat<CR>
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
nnoremap <F5> :exec '!sensible-browser % &'<CR>
"Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
"Short cut to cicle through the buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
"visual bell for errors
"set visualbell

"line number and relative line number
set number
set relativenumber
set ruler

"Shares the system clipboard
set clipboard=unnamed

"Set one line to be always shown below or above the cursor
set scrolloff=1

"Set to split always right
"set splitright

"Set some 'sensible' defaults
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set backspace=indent,eol,start
set complete-=i
"set list!
set listchars=tab:▸\ ,eol:¬,trail:·,space:·
"tab:▹\ ,
"Alternative menu
"set wildmenu

"Avoid producing any extraneous files
set nobackup
set nowritebackup
set noswapfile

"Set colors and fonts
syntax on
if has('gui_running')
    set background=dark
    set termguicolors
    "Black background (before colorscheme=quantum)
    let g:quantum_black=1
    colorscheme quantum
    "colorscheme neodark

    "To italicize comments:
    let g:quantum_italics=1

    set guifont=inconsolata\ for\ Powerline
    set guioptions-=T "remove the toolbar 

elseif &term == "rxvt-unicode-256color" || &term == "xterm-256color"
    set t_Co=256
    colorscheme one
    set background=dark
    "colorscheme neodark
    "To use 256-color in both of vim and gvim:
    "let g:neodark#use_256color = 1 " default: 0
    "To use your default terminal background:
    "let g:neodark#terminal_transparent = 1 " default: 0
else
    set t_Co=8
endif

"Highlight for the matching parenthesis.
highlight MatchParen guibg=#212121 guifg=#00ff00

"NERDTree configuration
let NERDTreeShowHidden=1
"Get rid of the "? show help...
let NERDTreeMinimalUI=1
"NERDTree Default window size
"let g:NERDTreeWinSize = 25
"Make NERDTree window resizable
"let NERDTreeWinSize=1

"Airline configuration
"Always dispalays airline
set laststatus=2

let g:airline#extensions#tabline#enabled = 1

if has('gui_running')
    let g:airline_theme='quantum'
else
    let g:airline_theme = 'onedark'
endif

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"NERDCommenter settings
" Add spaces after comment delimiters by default
"let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
"let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
"let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
"let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
"let g:NERDTrimTrailingWhitespace = 1

"Tern configuration
let g:tern_show_argument_hints = 'on_hold'
let g:tern_map_keys = 1
let g:tern_show_signature_in_pum = 1

"Highlight settings for youcompleteme hints
highlight Pmenu ctermfg=7 ctermbg=0
highlight PmenuSel ctermfg=0 ctermbg=7
"Turn off the preview (opening a scratch buffer) from the youcompleteme menu
set completeopt-=preview

"ALE configuration
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = [ 'prettier', 'eslint' ]
let g:ale_fixers['html'] = [ 'tidy' ]
let g:ale_javascript_prettier_options ='--tab-width 4 --single-quote --no-bracket-spacing --trailing-comma es5' 
let g:ale_echo_msg_format = '%linter%: %s [%severity%]'
"let g:ale_sign_column_always = 1
"let g:ale_sign_error         = '--'
"let g:ale_sign_error         = '✘'
"let g:ale_sign_warning       = '🔸'
"let g:ale_sign_warning       = '⚠️'
let g:ale_linters = {'jsx': ['eslint'],'sql': ['sqlint'] }
let g:ale_linter_aliases = {'jsx': 'css'}
"let g:ale_set_highlights = 0
"let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ OK']
