""""""""""""""""""""""""""Vundle"""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'Valloric/YouCompleteMe' " :(
Plugin 'ajh17/VimCompletesMe'
Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/tComment'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kshenoy/vim-signature'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
"Plugin 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'
Plugin 'wellle/targets.vim'
Plugin 'indentpython.vim'
Plugin 'fisadev/vim-isort'
Plugin 'Yggdroot/indentLine'
"Plugin 'tmhedberg/simpylfold'
Plugin 'michaeljsmith/vim-indent-object'
"Plugin 'shemerey/vim-project'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"
"""""""""""""""""""""""""""Pathogen""""""""""""""""""""""""""""""""""""
""pathogen
"execute pathogen#infect()
"syntax on
"filetype plugin indent on

"""""""""""""""""""""""""""NERDTree""""""""""""""""""""""""""""""""""""
"open automatically if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"""""""""""""""""""""""""""Syntastic"""""""""""""""""""""""""""""""""""
"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=3

nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>
""""""""""""""""""""""""""""Colors"""""""""""""""""""""""""""""""""""""
"colors 
syntax enable
set background=dark
"let g:solarized_termcolors=256
colorscheme solarized
"colorscheme elflord

"cursor colors
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif

""""""""""""""""""""""""""""Leader Key""""""""""""""""""""""""""""""""""
let mapleader=","
""""""""""""""""""""""""""""Other Shortcuts"""""""""""""""""""""""""""""
"press F3 to enter paste mode
set pastetoggle=<F3>

"space to toggle folding
"nnoremap <space> za

nnoremap <F2> :call NumberToggle()<cr>

map <C-n> :NERDTreeToggle<CR>

"make everything purty
autocmd FileType python nnoremap <F4> :0,$!yapf<Cr><C-o>:Isort<cr>

map <F5> :IndentLinesToggle<cr>
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - 
""""""""""""""""""""""""""I'm an idiot"""""""""""""""""""""""""""""""""
command! Q q
command! Qa qa
command! QA qa
command! Q1 q!
command! W w
command! Wq wq
command! WQ wq
""""""""""""""""""""""""""""Functions""""""""""""""""""""""""""""""""""
function! NumberToggle()
  if(&relativenumber == 1)
    set number
    set norelativenumber
  elseif(&number == 1)
    set nonumber
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunc

"syntastic location list
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open panel
        lopen
    endif
endfunction

"copy with line numbers
fu! YankNu(first, last) 
   let start=a:first 
   let l=[] 
   while start <= a:last 
           let l = add(l,printf("%".len(a:last) . "d %s",start , " " . getline(start))) 
           let start+=1 
   endwhile 
   return join(l,"\n") . "\n" 
endfu 

""""""""""""""""""""""""""Miscellaneous"""""""""""""""""""""""""""""""""
"indent to 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set autoindent

"for html files, 2 spaces
autocmd FileType html setlocal sw=2 sts=2 ts=2 expandtab
autocmd FileType htmldjango setlocal sw=2 sts=2 ts=2 expandtab
autocmd FileType css setlocal sw=2 sts=2 ts=2 expandtab

" Enable folding 
" set foldmethod=indent
" set foldlevel=99

"line under the cursor
set cursorline

"hybrid line numbers (absolute on cursor line, relative otherwise)
set relativenumber
set number

set equalprg=yapf

" special dirs for backup and swap files
set backupdir=~/.vim/backup
set directory=~/.vim/swap

set splitbelow
set splitright

" copy with line numbers
com! -nargs=0 -range Yank :let @+=YankNu(<line1>,<line2>) 
