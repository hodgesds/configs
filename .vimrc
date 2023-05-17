set encoding=utf-8
let mapleader = ","
syntax enable
set tags+=tags;$HOME

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

set smartindent
set tabstop=8
set shiftwidth=4
set softtabstop=8
set shiftwidth=8
set noexpandtab

set nocompatible

au BufRead,BufNewFile *BUCK             setfiletype buck
# au FileType buck nmap <leader>b !buck2 build ...
au FileType buck nmap <leader>b <Plug>(!buck build ... )

"inoremap jk <esc>

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'airblade/vim-gitgutter'
Plugin 'elzr/vim-json'
Plugin 'fatih/vim-go'
Plugin 'flazz/vim-colorschemes'
Plugin 'gmarik/Vundle.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'szw/vim-tags'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'tomlion/vim-solidity'
Plugin 'vim-airline/vim-airline'
Plugin 'rust-lang/rust.vim'
Plugin 'mhinz/vim-startify'
"Plugin 'tpope/vim-rails'
"Plugin 'jodosha/vim-godebug'
" FUCKING JAVASCRIPT
"Plugin 'jelera/vim-javascript-syntax'
Plugin 'vim-airline/vim-airline-themes'
" FUCKING PHP
"Plugin 'joonty/vim-phpqa.git'
" Python
"Plugin 'jmcantrell/vim-virtualenv'
Plugin 'nvie/vim-flake8'

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
set splitright

autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red
set listchars=tab:>.,trail:.,extends:#,nbsp:.

let NERDTreeIgnore = ['\.pyc$', '*__pycache__$']
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
let g:go_metalinter_autosave = 0
"let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

au FileType go nmap <leader>b <Plug>(go-doc-browser)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>d <Plug>(go-doc-vertical)
au FileType go nmap <leader>f <Plug>(go-files)
au FileType go nmap <leader>g <Plug>(go-generate)
au FileType go nmap <leader>i <Plug>(go-imports)
au FileType go nmap <leader>l <Plug>(go-lint)
au FileType go nmap <leader>m <Plug>(go-metalinter)
au FileType go nmap <leader>p <Plug>(go-deps)
au FileType go nmap <leader>r <Plug>(go-rename)
au FileType go nmap <leader>t <Plug>(go-info)
au FileType go nmap <leader>v <Plug>(go-vet)
au FileType go nmap <leader>x <Plug>(go-run-vertical)
au FileType go nmap <leader>z <Plug>(go-coverage-clear)

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

" rust
let g:rustfmt_autosave = 1
au FileType rust nmap <leader>c <Plug>(!cargo build)
