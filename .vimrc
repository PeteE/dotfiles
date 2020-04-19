set expandtab
set tabstop=4
set shiftwidth=4
set incsearch
set hlsearch
set ignorecase
set et
syntax on
set laststatus=2
set number relativenumber
set path+=**
set wildmenu
set ruler
set updatetime=100
let g:netrw_banner=0

set nocompatible
filetype off

filetype plugin indent on

let g:gitgutter_enabled=1
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_grep = 'ag'

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
"
" Plug 'ycm-core/YouCompleteMe'
" Plug 'tmhedberg/SimpylFold'
" Plug 'Konfekt/FastFold'
" Plug 'benmills/vimux'
" Plug 'jaredgorski/spacecamp'

Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'mtth/scratch.vim'
Plug 'mileszs/ack.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-smooth-scroll'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'honza/vim-snippets'
Plug 'kshenoy/vim-signature'
Plug 'andrewstuart/vim-kubernetes'
Plug 'ervandew/supertab'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'romainl/vim-qf'
Plug 'junegunn/vim-peekaboo'
Plug 'markonm/traces.vim'
Plug 'unblevable/quick-scope'
Plug 'fatih/vim-go'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'

Plug 'rbong/vim-flog'
let g:flog_default_arguments = { 'max_count': 1000 }


"Plug 'JamshedVesuna/vim-markdown-preview'

call plug#end()

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let mapleader = ","
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>= <C-w>=

" peakaboo
let g:peekaboo_window = 'vertical abo 60new'
let g:peekaboo_compact = 0
let g:peekaboo_delay = 300

" vim-qf
let g:qf_max_height = 20

" quick-scope
"let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

let NERDTreeShowHidden=1
nnoremap <Leader>nt :NERDTreeToggle<CR>

let g:ackhighlight=1
cnoreabbrev Ack Ack!
nnoremap <Leader>a yw:Ack!<Space><CR>0

" let g:ycm_add_preview_to_completeopt = 1

set statusline=%f\ -\ FileType:\ %y

" Smoothscroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 4)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 4)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" Insert timestamp
nmap <Leader>ts i<C-R>=strftime("%Y-%m-%d %H:%M %Z")<CR><Esc>

" SimplyFold
let g:SimpylFold_docstring_preview = 0

" set colorscheme to nord
" let g:nord_uniform_diff_background = 1
" let g:nord_italic = 1
" let g:nord_italic_comments = 1

" fzf
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>

augroup my_colours
    autocmd!
        autocmd ColorScheme nord hi SpellBad cterm=Underline ctermfg=Red
    augroup END
colorscheme nord

set diffopt+=vertical

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

let g:tmux_navigator_disable_when_zoomed = 1

" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"map <Space> :noh<cr>
noremap <Space> :

nmap <Leader>cp :let @+ = expand("%")<cr>
