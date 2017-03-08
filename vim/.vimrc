set nocompatible

function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/.vim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
        execute 'source' config_file
    endif
  endfor
endfunction

"filetype off " required!
syntax on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc("~/.vim/bundle/")


" Plugins are each listed in their own file. Loop and source ftw
"----------------------------------------------------------------
call vundle#begin() 
call s:SourceConfigFilesIn('rcplugins')
call vundle#end()


" comments out with # & space for ruby  
let g:NERDCustomDelimiters = { 'ruby': { 'left': '#', 'leftAlt': '', 'rightAlt': '' } }
let g:NERDSpaceDelims=1


filetype plugin indent on

let mapleader = ","
" no sure 
let g:user_emmet_leader_key='<C-Z>'
let g:user_emmet_install_global = 0
set pastetoggle=<F10>

" custom shortcuts 
nnoremap <C-s> :w<CR>
nnoremap <leader>ev :vs $MYVIMRC<CR>
nnoremap <leader>do :vi ~/sites/dotfiles<CR>
nnoremap <leader>gs :Gstatus<CR><C-W>15+
nnoremap <leader>m :NERDTreeToggle<CR>
nnoremap <leader>a :Ack
nnoremap <leader>rs :!clear;rspec --color spec<CR>
nnoremap <leader>rr :!clear;rspec --format documentation
nnoremap <leader>d :bd<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader><cr> :noh<CR>
nnoremap <leader>z :TlistToggle<CR>
nnoremap <leader>[ :nohl<Cr>
nnoremap <leader>x :wq<Cr>
nnoremap <leader>f <C-W>f
nnoremap <leader>v :CtrlP<CR>
nnoremap <leader>se :YcmRestartServer<CR>
nnoremap <leader>%  :%s/
nnoremap <leader>p  :r !pbpaste<CR>  
map <Leader>; :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>b :call RunAllSpecs()<CR>

" adding pry
au FileType ruby map <buffer> <silent> <leader>ao orequire 'pry'; binding.pry<esc>
au FileType elixir map <buffer> <silent> <leader>ao orequire IEx; IEx.pry<esc>

vnoremap < <gv
vnoremap > >gv
vnoremap . :norm.<CR>

"======================= Indention==================
set autoindent
set smartindent

"======================= Size of window & Fonts ==============
set winheight=999
set winheight=5
set winminheight=5
set winwidth=84
set guifont=Inconsolata\ 10.5
set guioptions-=Be

"====================== Color Scheme =================
colorscheme wombat
set t_Co=256
set term=screen-256color
set colorcolumn=80
set cursorline "highlights the current line you are on

let g:molokai_original = 1 "sets color schem to molokai 

"===================== Search =======================
nnoremap n nzz
nnoremap N Nzz
set showmatch
set incsearch "will start searching as when you type first character
set smartcase
set ignorecase
set gdefault " /g search and replace


set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start
set list
set listchars=tab:▸\ ,eol:¬,nbsp:⋅,trail:•
set noswapfile
set number
set ts=2 sts=2 sw=2 expandtab
set visualbell
set tags=tags;
set omnifunc=syntaxcomplete#Complete
set updatetime=1000
set shell=/bin/zsh
set clipboard=unnamedplus

" adds to statusline
set laststatus=2
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Autocommands {{{

" Markdown gets auto textwidth
au Bufread,BufNewFile *.md set filetype=markdown textwidth=79
au Bufread,BufNewFile *.markdown set textwidth=79

" Statusline 
hi User1 ctermbg=white ctermfg=black guibg=#89A1A1 guifg=#002B36
hi User2 ctermbg=red ctermfg=white guibg=#aa0000 guifg=#89a1a1

function! GetCWD()
 return expand(":pwd")
endfunction

function! IsHelp()
  return &buftype=='help'?' (help) ':''
endfunction

function! GetName()
  return expand("%:t")==''?'<none>':expand("%:t")
endfunction

" TList commands neeed use more 
let Tlist_Use_Right_Window=1
let Tlist_Enable_Fold_Column=0
let Tlist_Show_One_File=1 " especially with this one
let Tlist_Compact_Format=1
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'

let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 0

autocmd FileType ruby compiler ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

" run rubocop through the entire project in my tmux window and pane of choice
map <leader>bo :call Send_to_Tmux("rubocop\n")<CR>

" run rubocop on the current file in my tmux window and pane of choice
map <leader>bc :call Send_to_Tmux("rubocop -a ". expand('%:p') ."\n")<CR>

if has("autocmd")
  augroup filetype_elixir
    au!
    autocmd FileType elixir autocmd BufEnter * :syntax sync fromstart
  augroup END
endif

if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
  let previous_winnr = winnr()
  silent! execute "wincmd " . a:wincmd
  if previous_winnr == winnr()
  call system("tmux select-pane -" . a:tmuxdir)
  redraw!
  endif
endfunction
  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif
