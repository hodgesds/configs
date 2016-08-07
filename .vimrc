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
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-markdown'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rking/ag.vim'
Plugin 'elzr/vim-json'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'szw/vim-tags'
"Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/vim-easy-align'
"Plugin 'tpope/vim-fireplace'
Plugin 'kien/ctrlp.vim'
"Plugin 'vim-scripts/mru.vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'vim-airline/vim-airline'
Plugin 'fatih/vim-go'
" FUCKING JAVASCRIPT
Plugin 'jelera/vim-javascript-syntax'
" FUCKING PHP
Plugin 'joonty/vim-phpqa.git'
" Go
Plugin 't-yuki/vim-go-coverlay'

" Python
Plugin 'jmcantrell/vim-virtualenv'

call vundle#end()

filetype plugin indent on

" rust
let g:rustfmt_autosave = 1

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
"let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" airline
let g:airline#extensions#tabline#enabled = 1

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0

" emmet only html, css files
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

nmap <F8> :TagbarToggle<CR>
