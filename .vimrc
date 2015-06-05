set encoding=utf-8
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
syntax enable
set tags+=tags;$HOME
set hlsearch
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set nocompatible 
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-markdown'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rking/ag.vim'
Plugin 'elzr/vim-json'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'itchyny/lightline.vim'
"Plugin 'tpope/vim-fireplace'
Plugin 'kien/ctrlp.vim'
"Plugin 'vim-scripts/mru.vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'bling/vim-airline'
call vundle#end()

filetype plugin indent on

set number
set ruler

set timeout ttimeoutlen=50
nnoremap <A-j> <C-W><C-J> 
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>
set splitbelow
set splitright
" inoremap jk <esc>

autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red
set listchars=tab:>.,trail:.,extends:#,nbsp:.

let NERDTreeIgnore = ['\.pyc$']
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
let g:NERDTreeWinSize=20


func! DeleteTrailingWS()
   exe "normal mz"
   %s/\s\+$//ge
   exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()


let g:airline#extensions#tabline#enabled = 1
