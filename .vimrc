filetype plugin indent on
syntax enable

let mapleader = ","
set tags+=tags;$HOME

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

set nocompatible
set noexpandtab
set number
set ruler
set shiftwidth=4
set shiftwidth=8
set smartindent
set softtabstop=8
set splitright
set tabstop=8
set updatetime=300

"inoremap jk <esc>
if has('nvim')
  " inoremap <silent><expr> <c-space> coc#refresh()
  nnoremap <A-j> <C-W><C-J>
  nnoremap <A-k> <C-W><C-K>
  nnoremap <A-l> <C-W><C-L>
  nnoremap <A-h> <C-W><C-H>
else
  set timeout ttimeoutlen=50
  execute "set <A-j>=\ej"
  execute "set <A-k>=\ek"
  execute "set <A-l>=\el"
  execute "set <A-h>=\eh"
  " inoremap <silent><expr> <c-@> coc#refresh()
  " nmap <silent> gd <Plug>(coc-definition)
  " nmap <silent> gy <Plug>(coc-type-definition)
  " nmap <silent> gi <Plug>(coc-implementation)
  " nmap <silent> gr <Plug>(coc-references)
  map <up> <C-w><up>
  map <down> <C-w><down>
  map <left> <C-w><left>
  map <right> <C-w><right>
  noremap <A-j> <C-w><up>
  noremap <A-k> <C-w><down>
  noremap <A-l> <C-w><right>
  noremap <A-h> <C-w><left>
endif

" OSX
nnoremap ∆ <C-W><C-J>
nnoremap ˚ <C-W><C-K>
nnoremap ˙ <C-W><C-H>
nnoremap ¬ <C-W><C-L>


au BufRead,BufNewFile *BUCK setfiletype buck
au FileType buck nmap <leader>b <Plug>(buck2 build ...)
au BufRead,BufNewFile *.rs setfiletype rust
au FileType rust nmap <leader>b :!cargo build --release<Cr>
au BufRead,BufNewFile *.ebuild setfiletype ebuild
au FileType ebuild nmap <leader>b :!ebuild *.ebuild digest<Cr>

nmap <leader>n :set invnumber<Cr>


if has('nvim')

else
  set encoding=utf-8
endif

call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf'
Plug 'junegunn/vim-easy-align'
Plug 'kien/ctrlp.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'szw/vim-tags'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline-themes'
call plug#end()


" coc
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


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


" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'molokai'

" ale
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 0
let g:ale_linters_explicit = 1
"let g:ale_fixers = {'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines']}
let g:ale_linters = {'rust': ['analyzer', 'trim_whitespace', 'remove_trainling_lines']}

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_autosave = 0

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

nmap <F8> :TagbarToggle<CR>

" rust
let g:rustfmt_autosave = 0
au FileType rust nmap <leader>c <Plug>(!cargo build)
