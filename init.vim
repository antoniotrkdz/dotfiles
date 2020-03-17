" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc
"________________________________________________/\\\__________________________
"____________________________/\\\________________\/\\\_________________________
"____/\\\____________________\/\\\________________\/\\\________________________
"__/\\\\\\\\\\\__/\\/\\\\\\\__\/\\\\\\\\___________\/\\\___/\\\\\\\\\\\________
"__\////\\\////__\/\\\/////\\\_\/\\\////\\\____/\\\\\\\\\__\///////\\\/________
"______\/\\\______\/\\\___\///__\/\\\\\\\\/____/\\\////\\\_______/\\\/_________
"_______\/\\\_/\\__\/\\\_________\/\\\///\\\___\/\\\__\/\\\_____/\\\/__________
"________\//\\\\\___\/\\\_________\/\\\_\///\\\_\//\\\\\\\/\\__/\\\\\\\\\\\____
"__________\/////____\///__________\///____\///___\///////\//__\///////////____
"______________________________________________________________________________

" ╦  ╔╗╔  ╦  ╔╦╗     ╦  ╦  ╦  ╔╦╗                                            
" ║  ║║║  ║   ║      ╚╗╔╝  ║  ║║║                                            
" ╩  ╝╚╝  ╩   ╩   o   ╚╝   ╩  ╩ ╩  ──────────────────────────────────────────── 
set completeopt+=noinsert,menuone

" Turn off the preview (opening a scratch buffer) from the YouCompleteMe menu
set completeopt-=preview

" Highlight the current line and column only in the current window
autocmd WinLeave * set nocursorline nocursorcolumn
autocmd WinEnter * set cursorline cursorcolumn

" Disable all error bells
set belloff=all

" Line number and relative line number
set number
set relativenumber
set ruler

" Show the command as it's being typed
set showcmd

" Shares the system clipboard
set clipboard=unnamedplus

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

" Alternative menu
set wildmenu

"Avoid showing the mode on the last line
set noshowmode

" Searching
set ignorecase smartcase
"set incsearch "handled by <leader>i -- see mappings
" Use the silversearcher-ag to perform searches (like ack, but faster) 
set grepprg=ag\ -i

" Enable syntax
syntax on

" Enable filetype-specific plugins and indenting
filetype plugin indent on

" ╔═╗  ╦    ╦ ╦  ╔═╗  ╦  ╔╗╔  ╔═╗
" ╠═╝  ║    ║ ║  ║ ╦  ║  ║║║  ╚═╗
" ╩    ╩═╝  ╚═╝  ╚═╝  ╩  ╝╚╝  ╚═╝
"Autoinstall vim plug if not already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"set the runtime path to include Vundle and initialise
call plug#begin('~/.config/nvim/plugged')

  " Highlight briefly every yank text
  Plug 'machakann/vim-highlightedyank'
  "Git wrapper
  Plug 'tpope/vim-fugitive'
  " Symbols for git changes tracking
  "Plug 'mhinz/vim-signify'
  Plug 'airblade/vim-gitgutter'
  " NERDTree
  Plug 'scrooloose/nerdtree'
  Plug 'jistr/vim-nerdtree-tabs'
  " Airline bottom bar (and top one)
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Patched fonts needed to display fancy airline
  " Copy the desired font(s) in .local/share/fonts
  " Set the required font(s) in the console settings
  Plug 'powerline/fonts'
  "Commenter
  "Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-commentary'
	"Code intellisense completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "Ale Async Linting (+formatting) as you type
  Plug 'w0rp/ale'
  "Language specific
  Plug 'posva/vim-vue'
  Plug 'pangloss/vim-javascript'
  Plug 'leafOfTree/vim-svelte-plugin'
  "wisely add 'end' in ruby (maybe bash)
  Plug 'tpope/vim-endwise'
  "Emmet for HTML editing, <c-y> to trigger completion
  Plug 'mattn/emmet-vim'
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
  Plug 'junegunn/fzf.vim'
  "Asynchronously fly grep (SpaceVim)
  Plug 'wsdjeg/FlyGrep.vim'
  "Multiple cursors
  Plug 'terryma/vim-multiple-cursors'
  "Underlines a word element
  Plug 'itchyny/vim-cursorword'
  " Much simpler rainbow parentheses
  Plug 'junegunn/rainbow_parentheses.vim'
  "Help for vim in vim
  Plug 'lifepillar/vim-cheat40'
  "Easy, <leader><leader>f<letter> you want to move to
  Plug 'easymotion/vim-easymotion'
  "Markdown editor (git READMEs)
  Plug 'shime/vim-livedown'
  "Database completion
  Plug 'vim-scripts/dbext.vim'
  "i3wm .config syntax
  Plug 'PotatoesMaster/i3-vim-syntax'
  "Vim-markbar
  Plug 'Yilin-Yang/vim-markbar'
  "Alternative sudo.vim for Vim and Neovim
  Plug 'lambdalisue/suda.vim'

  "Unmanged plugin to show terminal colors, use :XtermColorTable 
  Plug '~/.vim/xterm-color-table.vim'
  " Plugin to highlight matchit.
  Plug '~/.vim/99-hl-matchlines.vim'

  "Theme (CLI)
  Plug 'neutaaaaan/iosvkem'

call plug#end()

" ╔═╗  ╦    ╦ ╦  ╔═╗  ╦  ╔╗╔    ╔═╗  ╔═╗  ╔╦╗  ╔╦╗  ╦  ╔╗╔  ╔═╗  ╔═╗
" ╠═╝  ║    ║ ║  ║ ╦  ║  ║║║    ╚═╗  ║╣    ║    ║   ║  ║║║  ║ ╦  ╚═╗
" ╩    ╩═╝  ╚═╝  ╚═╝  ╩  ╝╚╝    ╚═╝  ╚═╝   ╩    ╩   ╩  ╝╚╝  ╚═╝  ╚═╝
" COC SETTINGS ----------------------------------------------------------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
" Only related to typescript.
"set nobackup
"set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
" Also affects Git Gutter update.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  if (pumvisible())
    " Solves compatibility issue with endwise plugin 
    inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  endif
else
  imap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"COC SETTINGS END -------------------------------------------------------------

" Vue files
autocmd BufReadPost,BufNewFile *.vue setlocal filetype=vue

" Svelte files
autocmd BufReadPost,BufNewFile *.svelte setlocal filetype=svelte

" RainbowParentheses activation based on file type
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END
" RainbowParentheses Customization
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{', '}']]

" Option for Match HTML Tag plugin
let g:mta_filetypes = {'html': 1, 'xhtml': 1, 'xml': 1, 'javascript': 1, 'php': 1}

" NERDTree config
let NERDTreeShowHidden=1
" Get rid of the "? show help...
let NERDTreeMinimalUI=1

" Airline config
" Always displays airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
if has('gui_running')
    let g:airline_theme='quantum'
endif
if has('nvim')
    let g:airline_theme='behelit'
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
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Suda.vim prefix
let g:suda#prefix = 'su//'

" DelimitMate config
au FileType html,vim let b:delimitMate_matchpairs = "(:),[:],{:},<:>"

" A.L.E. config
let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'jsx': ['prettier', 'eslint'],
      \ 'html': [ 'tidy' ],
      \ 'css': ['prettier', 'stylelint'],
      \ 'scss': ['prettier', 'stylelint'],
      \ }
let g:ale_linters = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'jsx': ['prettier', 'eslint'],
      \ 'sql': ['sqlint'],
      \ 'bash': ['language_server','shellcheck'],
      \ 'sh': ['language_server','shellcheck'],
      \ 'html': [ 'tidy' ],
      \ 'css': ['prettier', 'stylelint'],
      \ 'scss': ['prettier', 'stylelint'],
      \ 'lua': ['luacheck'],
      \ }
let g:ale_linter_aliases = {'jsx': 'css'}
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_format = '%linter%: %s [%severity%]'
"let g:ale_sign_error         = '>>' "Default
"let g:ale_sign_warning       = '--' "Default
let g:ale_sign_info          = '..'
"
" ╔╦╗╔═╗╔═╗╔═╗╦╔╗╔╔═╗╔═╗
" ║║║╠═╣╠═╝╠═╝║║║║║ ╦╚═╗
" ╩ ╩╩ ╩╩  ╩  ╩╝╚╝╚═╝╚═╝
" make sure there are no spaces at the end!
inoremap jk <esc>
inoremap kj <esc>
vnoremap v <esc>
nnoremap H ^
nnoremap L $
nnoremap <C-s> :write<CR>
inoremap <C-s> :write<CR>
nnoremap <silent> <F3> :NERDTreeTabsToggle<CR>
" noremap <F4> :ALEFix<CR>
noremap <S-A-f> :Format<CR>
" Open the current file in default browser
nnoremap <F5> :execute '!sensible-browser % &'<CR>
" Edit vimrc with f5 and source it with f6
nmap <silent> <leader><f5> :e $MYVIMRC<CR>
nmap <silent> <leader><f6> :so $MYVIMRC<CR>
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
map <Leader>m <Plug>ToggleMarkbar
" surround by quotes - frequently use cases of vim-surround
map <leader>" ysiw"<CR>
map <leader>' ysiw'<CR>
" Make Y Act like D and C
nnoremap Y y$
" indent without kill the selection in vmode
vmap < <gv
vmap > >gv
" remap the annoying u in visual mode
vmap u y
" shortcut to substitute current word under cursor
nnoremap <leader>[ :%s/<c-r><c-w>//gc<left><left><left>

" Open a terminal on the bottom
noremap <leader>b :botright 13sp term://$SHELL<CR>i
" mappings to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>

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
colorscheme Iosvkem

" Italic for comments.
highlight Comment cterm=italic gui=italic

" Highlight for the matching parenthesis.
highlight MatchParen guibg=NONE guifg=#00ff00 gui=bold

" Highlight for the trailing space
highlight ExtraWhitespace ctermbg=red guibg=#ff0000
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" Highlight the 80th column
set colorcolumn=80
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
