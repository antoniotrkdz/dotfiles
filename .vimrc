"__________________________________________________/\\\_________________________
"______________________________/\\\________________\/\\\________________________
"______/\\\____________________\/\\\________________\/\\\_______________________
"____/\\\\\\\\\\\__/\\/\\\\\\\__\/\\\\\\\\___________\/\\\___/\\\\\\\\\\\_______
"____\////\\\////__\/\\\/////\\\_\/\\\////\\\____/\\\\\\\\\__\///////\\\/_______
"_______\/\\\______\/\\\___\///__\/\\\\\\\\/____/\\\////\\\_______/\\\/_________
"________\/\\\_/\\__\/\\\_________\/\\\///\\\___\/\\\__\/\\\_____/\\\/__________
"_________\//\\\\\___\/\\\_________\/\\\_\///\\\_\//\\\\\\\/\\__/\\\\\\\\\\\____
"___________\/////____\///__________\///____\///___\///////\//__\///////////____
"_______________________________________________________________________________
"_______________________________________________________________________________
"___________________/\\\________________________________________________________
"______/\\\____/\\\_\///_____/\\\\\__/\\\\\____/\\/\\\\\\\_____/\\\\\\\\________
"______\//\\\__/\\\___/\\\__/\\\///\\\\\///\\\_\/\\\/////\\\__/\\\//////________
"________\//\\\/\\\___\/\\\_\/\\\_\//\\\__\/\\\_\/\\\___\///__/\\\______________
" _________\//\\\\\____\/\\\_\/\\\__\/\\\__\/\\\_\/\\\________\//\\\____________
"____/\\\____\//\\\_____\/\\\_\/\\\__\/\\\__\/\\\_\/\\\_________\///\\\\\\\\____
"____\///______\///______\///__\///___\///___\///__\///____________\////////____
"_______________________________________________________________________________

set nocompatible "IMproved, required

"This command makes vim start a file with all folds closed
"set foldlevelstart=0

" Mucomplete + Ncm2 mandatory Vim settings:
" :help Ncm2PopupOpen for more information
set completeopt+=noinsert,menuone,noselect

" Turn off the preview (opening a scratch buffer) from the YouCompleteMe menu
set completeopt-=preview

" Disable all error bells
set belloff=all

" Line number and relative line number
set number
set relativenumber
set ruler

" Show the command as it's being typed
set showcmd

" Shares the system clipboard
"set clipboard=unnamed
set clipboard=unnamedplus

" Set one line to be always shown below or above the cursor
set scrolloff=1

" Set to split always right
"set splitright

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
"tab:▹\ ,

" Alternative menu
set wildmenu

" Avoid producing any extraneous files
" Now is managed see backup block below
"set nobackup
"set nowritebackup
"set noswapfile

"Avoid showing the mode on the last line
set noshowmode

" Guiheadroom, room (in pixels) left above/below the window
set ghr=0
" Guipty	use a pseudo-tty for I/O to external commands
set guipty	"noguipty

" Searching
set ignorecase smartcase
"set incsearch "handled by <leader>i -- see mappings
" Use the silversearcher-ag to perform searches (like ack, but faster) 
set grepprg=ag\ -i

syntax on " syntax enable
filetype plugin indent on " Enable filetype-specific plugins and indenting

" Change the cursor shape For VTE compatible terminals
" (urxvt, st, xterm, gnome-terminal 3.x, Konsole KDE5 and others)
" See https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).
" If there is a delay when hitting ESC to exit insert mode back to normal mode
" and show the block as cursor again. To fix:
" set ttimeout
" set ttimeoutlen=1
" set ttyfast

"  ____  _             _
" |  _ \| |_   _  __ _(_)_ __  ___
" | |_) | | | | |/ _` | | '_ \/ __|
" |  __/| | |_| | (_| | | | | \__ \
" |_|   |_|\__,_|\__, |_|_| |_|___/
"                 |___/
"Autoinstall vim plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"set the runtime path to include Vundle and initialise
call plug#begin('~/.vim/plugged')

  " Highlight briefly every yank text
  Plug 'machakann/vim-highlightedyank'
  "Git wrapper
  Plug 'tpope/vim-fugitive'
  "Symbols for git changes tracking
  " Plug 'mhinz/vim-signify'
  Plug 'airblade/vim-gitgutter'
  "NERDTree
  Plug 'scrooloose/nerdtree'
  Plug 'jistr/vim-nerdtree-tabs'
  "Airline bottom bar (and top one)
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  "Patched fonts needed to display fancy airline
  "Copy the desired font(s) in .local/share/fonts
  "set the required font(s) in the console settings
  Plug 'powerline/fonts'
  "Commenter
  Plug 'tpope/vim-commentary'
  "Ale Async Linting (+formatting) as you type
  Plug 'w0rp/ale'
  "Language specific
  " Plug 'pangloss/vim-javascript'
  " Plug 'vim-ruby/vim-ruby'
  " Plug 'tpope/vim-rails'
  " Plug 'StanAngeloff/php.vim'
  "wisely add 'end' in ruby (maybe bash)
  Plug 'tpope/vim-endwise'
  "Emmet for HTML editing, <c-y> to trigger completion
  " Plug 'mattn/emmet-vim'
  "Colour preview in code
  Plug 'ap/vim-css-color'
  "Always highlights the enclosing XML/HTML tags 
  Plug 'valloric/matchtagalways'
  "Surround - surround or change the surround an item with "''() etc.
  Plug 'tpope/vim-surround'
  " Easily search for, substitute, and abbreviate multiple variants of a word
  Plug 'tpope/vim-abolish'
  "Doubles quotes and parenthesis on the fly
  Plug 'raimondi/delimitmate'
  "UNIX shell commands
  Plug 'tpope/vim-eunuch'
  "Fuzzy files search (also avialble in bash)
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  "CtrlP Fuzzy (file) search
  Plug 'ctrlpvim/ctrlp.vim'
  "Asynchronously fly grep (SpaceVim)
  Plug 'wsdjeg/FlyGrep.vim'
  "Multiple cursors
  Plug 'terryma/vim-multiple-cursors'
  "Underlines a word element
  Plug 'itchyny/vim-cursorword'
  "Help for vim in vim
  Plug 'lifepillar/vim-cheat40'
  "Easy, <leader><leader>s<letter> you want to move to
  Plug 'easymotion/vim-easymotion'
  "Markdown editor (git READMEs)
  Plug 'shime/vim-livedown'
  "Database completion
  " Plug 'vim-scripts/dbext.vim'
  "i3wm .config syntax
  Plug 'PotatoesMaster/i3-vim-syntax'
  "Vim-markbar
  Plug 'Yilin-Yang/vim-markbar'

  "Alternative sudo.vim for Vim and Neovim
  Plug 'lambdalisue/suda.vim'

  "Unmanged plugin to show terminal colors
  Plug '~/.vim/xterm-color-table.vim'

  " Uncomplicated alternative to vim-signature (shows mark in gutter)
  " Here in place of vim-markbar
  Plug '~/.vim/marksigns.vim'
  " Use % to jump between do - end, if - end, etc.
  Plug '~/.vim/99-hl-matchlines.vim' " Plugin to highlight matchit.

  " "to be configured
  " Plug 'bfredl/nvim-miniyank'
  " Plug 'moll/vim-bbye'
  " Plug 'vim-vdebug/vdebug'
  "Autoformat for other files (not js) - using A.L.E.
  "Plug 'chiel92/vim-autoformat'
  "Added vim snippets for code autofilling - ToDo: learn how it works!
  "Plug 'SirVer/ultisnips'
  "Perform insert mode completions with Tab - see TabOrComplete function
  "Plug 'ervandew/supertab'

  "Themes (for GUI and CLI)
  Plug 'neutaaaaan/iosvkem'
  Plug 'KeitaNakamura/neodark.vim'
  Plug 'tomasr/molokai'
  Plug 'rakr/vim-one'
  Plug 'tyrannicaltoucan/vim-quantum'
  Plug 'vim-scripts/xoria256.vim'
  Plug 'haishanh/night-owl.vim'
  Plug 'jeffkreeftmeijer/vim-dim', {'branch': 'main'}

  "MUcomplete is a minimalist autocompletion plugin for Vim.
  " Plug 'lifepillar/vim-mucomplete'
  "YouCompleteMe + tern completer - only for javascript
  " Plug 'Valloric/YouCompleteMe', { 'for': 'javascript', 'do': './install.py --js-completer' }
  " Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }

call plug#end()

" packadd! matchit " Use % to jump between do - end, if - end, etc.
" source ~/.vim/99-hl-matchlines.vim " Plugin to highlight matchit.

"   ___  __          _            ____    __  __  _
"  / _ \/ /_ _____ _(_)__  ___   / __/__ / /_/ /_(_)__  ___ ____
" / ___/ / // / _ `/ / _ \(_-<  _\ \/ -_) __/ __/ / _ \/ _ `(_-<
"/_/  /_/\_,_/\_, /_/_//_/___/ /___/\__/\__/\__/_/_//_/\_, /___/
"            /___/                                    /___/
" Autocompletion with tab
" inoremap <m-Tab> <plug>(MUcompleteFwd)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Git Gutter update time in ms
set updatetime=100
" Alternative Signify
" let g:signify_vcs_list = [ 'git' ]

" Option for Match HTML Tag plugin
let g:mta_filetypes = {'html': 1, 'xhtml': 1, 'xml': 1, 'javascript': 1, 'php': 1}

" NERDTree configuration
let NERDTreeShowHidden=1
" Get rid of the "? show help...
let NERDTreeMinimalUI=1
" NERDTree Default window size
"let g:NERDTreeWinSize = 25
" Make NERDTree window resizable
"let NERDTreeWinSize=1

" Airline configuration
" Always dispalays airline
set laststatus=2

let g:airline#extensions#tabline#enabled = 1

if has('gui_running')
    let g:airline_theme='quantum'
  else
    let g:airline_theme='deus'
endif

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Unicode symbols
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

" Airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" YouCompleteMe configuration
" Tern configuration
let g:tern_show_argument_hints = 'on_hold'
let g:tern_map_keys = 1
let g:tern_show_signature_in_pum = 1

" Disable YCM for ruby filetype
" let g:ycm_filetype_blacklist = { 'ruby': 1 }
" let g:ycm_filetype_specific_completion_to_disable = { 'ruby': 1 }
"let g:ycm_max_num_identifier_candidates = 0

" DelimitMate config for ruby and others
au FileType eruby,ruby,html,vim let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
au Filetype eruby,ruby let b:delimitMate_quotes = "\" ' ` %"

" A.L.E. configuration
let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'jsx': ['prettier', 'eslint'],
      \ 'ruby': ['rubocop'],
      \ 'eruby': ['rubocop'],
      \ 'html': [ 'tidy' ],
      \ 'css': ['prettier', 'stylelint'],
      \ 'scss': ['prettier', 'stylelint'],
      \ 'php': ['php_cs_fixer', 'phpcbf']
      \ }
" ALE options for alternative JS code styling, kept here for reference.
" let g:ale_javascript_prettier_options ='--tab-width 2 --single-quote --no-bracket-spacing --trailing-comma es5'
let g:ale_linters = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'jsx': ['prettier', 'eslint'],
      \ 'sql': ['sqlint'],
      \ 'ruby': ['rubocop'],
      \ 'eruby': ['rubocop'],
      \ 'bash': ['shellcheck'],
      \ 'html': [ 'tidy' ],
      \ 'css': ['prettier', 'stylelint'],
      \ 'scss': ['prettier', 'stylelint'],
      \ 'lua': ['luacheck'],
      \ 'php': ['php_cs_fixer', 'phpcbf', 'phpmd']
      \ }
let g:ale_linter_aliases = {'jsx': 'css'}
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_format = '%linter%: %s [%severity%]'
"let g:ale_sign_error         = '>>' "Default
"let g:ale_sign_warning       = '--' "Default
let g:ale_sign_info          = '..'
"let g:ale_sign_error         = '✘'
"let g:ale_sign_warning       = '=='
"let g:ale_sign_warning       = '⚠️'
"let g:ale_set_highlights = 0
"let g:ale_sign_column_always = 1
"let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ OK']

" To enable Mucomplete automatic completion
if &filetype == 'javascript'
  let g:mucomplete#enable_auto_at_startup = 0 " javascript uses YCM
else
  let g:mucomplete#enable_auto_at_startup = 1
endif

" See also Mucomplete mandatory general settings below
let g:mucomplete#always_use_completeopt = 1
" Use <tab> nd <s-tab> to cycle between completion methods (omnifunc,
" buffer, etcif 0 use <C-h> and <C-j> (default).
let g:mucomplete#cycle_with_trigger = 1
let g:mucomplete#cycle_all = 1

" Suda.vim prefix
" let g:suda#prefix = 'su//'

"  ____ ____ ____ ____ ____ ____ ____ ____
" ||M |||A |||P |||P |||I |||N |||G |||S ||
" ||__|||__|||__|||__|||__|||__|||__|||__||
" |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
" make sure there are no spaces at the end!
inoremap jk <esc>
inoremap kj <esc>
vnoremap v <esc>
nnoremap <silent> <F2> :NERDTreeTabsToggle<CR>
"noremap <F3> :Autoformat<CR>
noremap <F4> :ALEFix<CR>
" Open the current file in default browser
nnoremap <F5> :execute '!sensible-browser % &'<CR>
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
nnoremap ã :cnext<CR>
nnoremap ö :cprevious<CR>
" Livedow markdown previewer toggle on/off
nnoremap <F6> :LivedownToggle<CR>

" Toggles_highlight of matchit results, for all matching pairs
" that are NOT Parens: (),[],{}; ie.: 'def|class|while|do' with 'end'.
" Toggle off to get tpope/endwise plugin do its job.
nnoremap <leader>p :call Toggle_Extra_Paren_HL()<CR>

" Compatibility between Mucomplete and EndWise
"imap <Plug>MyCR <Plug>(MUcompleteCR)
"imap <cr> <Plug>MyCR

" Needed for vim-markbar
map <Leader>m <Plug>ToggleMarkbar
let g:markbar_persist_mark_names = v:false

" surround by quotes - frequently use cases of vim-surround
map <leader>" ysiw"<cr>
map <leader>' ysiw'<cr>

" Make Y Act like D and C
nnoremap Y y$

" Searching on * stays on the word searched
nnoremap * *N

" indent without kill the selection in vmode
vmap < <gv
vmap > >gv

" remap the annoying u in visual mode
vmap u y

" shortcut to substitute current word under cursor
nnoremap <leader>[ :%s/<c-r><c-w>//gc<left><left><left>

" edit vimrc with f5 and source it with f6
nmap <silent> <leader><f5> :e $MYVIMRC<CR>
nmap <silent> <leader><f6> :so $MYVIMRC<CR>

" Use TAB to complete when typing words, else inserts TABs as usual.
" Note : usual completion is on <C-n>.
" SUPERSEEDED by Mucomplete installation, here for REFERENCE only.

" function! Tab_Or_Complete()
"   if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\S'
"     "if NOT at the start of the line AND the cursor is preceded by a
"     "NON-Whithespace character
"     if &filetype =~ 'e\=ruby' "if the filetype is ruby or eruby
"       return "\<C-x>\<C-o>"
"     else
"       return "\<C-n>"
"     endif
"   else
"     return "\<Tab>"
"   endif
" endfunction
" " map <tab> in insert mode to the function above
" inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

"  ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗
" ██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
" ██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗
" ██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║
" ╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║
"  ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
if has('gui_running')
  set guioptions-=T "remove the toolbar 
  set background=dark
  "Black background (before colorscheme=quantum)
  let g:quantum_black=1
  "To italicize comments:
  let g:quantum_italics=1
  colorscheme quantum
  " let g:molokai_original=1
  " let g:rehash256=1
  " colorscheme molokai
  " colorscheme neodark
  " if (has("termguicolors"))
    " set termguicolors
  " endif
  " colorscheme night-owl

  " Set font size based on screen size. When vertical height is greater than 1440
  " (i.e. an external monitor UHD is attached), use 13, else use 11.
  if system('xrandr | grep -oP "(?<=x)[0-9]+(?=.*\*)"') > 1440
    set guifont=Hack\ 13
  else
    set guifont=Hack\ 11
  endif
  " Hide ~ at the end of the buffer
  highlight EndOfBuffer guifg=bg
elseif &term =~ '\v.+-256color' || &term =="xterm-kitty"
  set t_Co=256
  set background=dark
  colorscheme Iosvkem
  " colorscheme one
  " colorscheme neodark
  "To use 256-color in both of vim and gvim:
  "let g:neodark#use_256color = 1 " default: 0
  "To use your default terminal background:
  " let g:neodark#terminal_transparent = 1 " default: 0
  highlight Pmenu ctermfg=0 ctermbg=8
  highlight PmenuSel ctermfg=15 ctermbg=139
  highlight PmenuSbar ctermbg=8
  highlight PmenuThumb ctermfg=7
  " Hide ~ at the end of the buffer
  highlight EndOfBuffer ctermfg=bg
else
  set t_Co=8
  set background=dark
  colorscheme dim
  highlight Pmenu ctermfg=15 ctermbg=8
  highlight PmenuSel ctermfg=15 ctermbg=0
  highlight PmenuSbar ctermbg=8
  highlight PmenuThumb ctermfg=7
endif

" Highlight for the matching parenthesis.
highlight MatchParen guibg=NONE guifg=#00ff00 gui=bold
" guibg=#212121=background=bg BG color of the QUANTUM colorscheme

" Highlight for the trailing space
highlight ExtraWhitespace ctermbg=red guibg=#ff0000
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" Highlight the 80th column
set colorcolumn=80
highlight ColorColumn ctermbg=52 guibg=#302222

" Highlight the current line and column only in the current window
autocmd vimEnter * set cursorline cursorcolumn
autocmd WinEnter * set cursorline cursorcolumn
autocmd WinLeave * set nocursorline nocursorcolumn

" autocmd InsertEnter,InsertLeave * set cul!

" Iovskem theme fixes (#1bid1e theme bg color, 234 cterm bg)
if g:colors_name=='Iosvkem'
  " Fix ALE signs highlight 
  hi ALEErrorSign cterm=bold ctermfg=203 gui=bold guifg=#ff2040
  hi ALEWarningSign cterm=bold ctermfg=220 gui=bold guifg=#fcbb20
  " Fix Signify highlight
  " hi SignifySignAdd ctermfg=34 guifg=#40bb40
  " hi SignifySignChange ctermfg=220 guifg=#fcbb20
  " hi SignifySignDelete ctermfg=167 guifg=#cc4040
  "Fix git-gutter highlight
  hi GitGutterChange ctermfg=220 guifg=#fcbb20
endif

" $$$$$$$\                      $$\
" $$  __$$\                     $$ |
" $$ |  $$ | $$$$$$\   $$$$$$$\ $$ |  $$\ $$\   $$\  $$$$$$\
" $$$$$$$\ | \____$$\ $$  _____|$$ | $$  |$$ |  $$ |$$  __$$\
" $$  __$$\  $$$$$$$ |$$ /      $$$$$$  / $$ |  $$ |$$ /  $$ |
" $$ |  $$ |$$  __$$ |$$ |      $$  _$$<  $$ |  $$ |$$ |  $$ |
" $$$$$$$  |\$$$$$$$ |\$$$$$$$\ $$ | \$$\ \$$$$$$  |$$$$$$$  |
" \_______/  \_______| \_______|\__|  \__| \______/ $$  ____/
"                                                   $$ |
"                                                   $$ |
"                                                   \__|
if isdirectory($HOME . '/.vim/backup') == 0
	:silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
"   If you have .vim-swap in the current directory, it'll use that.
"   Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
	:silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo.vim

if exists("+undofile")
	" undofile - This allows you to use undos after exiting and restarting
	" This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
	" :help undo-persistence
	if isdirectory($HOME . '/.vim/undo') == 0
		:silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
	endif
	set undodir=./.vim-undo//
	set undodir+=~/.vim/undo//
	set undofile
endif
