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

Plug 'bling/vim-airline'

Plug 'tpope/vim-surround'

Plug 'easymotion/vim-easymotion'

call plug#end()

"always dispalays vim-airline
set laststatus=2

"visual bell for errors
set visualbell

"line number and relative line number
set number
set relativenumber

