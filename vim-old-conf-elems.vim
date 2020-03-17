"This command makes vim start a file with all folds closed
"set foldlevelstart=0
"
" Mucomplete + Ncm2 mandatory Vim settings:
" :help Ncm2PopupOpen for more information
"
" set completeopt+=noinsert,menuone,noselect
"
" set clipboard=unnamed

" Avoid producing any extraneous files
" Now is managed see backup block below
"set nobackup
"set nowritebackup
"set noswapfile

"tab:▹\ ,

" restore the position of the last cursor when you open a file
" autocmd vimrc BufReadPost * call general#RestorePosition()

" Git gutter 
" Alternative Signify
" let g:signify_vcs_list = [ 'git' ]

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

" Autocompletion with tab
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"noremap <F3> :Autoformat<CR>

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

" NERDTree Default window size
"let g:NERDTreeWinSize = 25
" Make NERDTree window resizable
"let NERDTreeWinSize=1

" ALE options for alternative JS code styling, kept here for reference.
" let g:ale_javascript_prettier_options ='--tab-width 2 --single-quote --no-bracket-spacing --trailing-comma es5'

"let g:ale_sign_error         = '✘'
"let g:ale_sign_warning       = '=='
"let g:ale_sign_warning       = '⚠️'
"let g:ale_set_highlights = 0
"let g:ale_sign_column_always = 1
"let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ OK']

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.config/nvim/viminfo.neovim

" Fix Signify highlight
" hi SignifySignAdd ctermfg=34 guifg=#40bb40
" hi SignifySignChange ctermfg=220 guifg=#fcbb20
" hi SignifySignDelete ctermfg=167 guifg=#cc4040

" highlight EndOfBuffer ctermfg=bg guifg=bg
" guibg=#212121=background=bg BG color of the QUANTUM colorscheme
