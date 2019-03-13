" vim-plug (https://github.com/junegunn/vim-plug) settings
" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

let os = system("uname")
let isLinux = (os == "Linux\n")
let useLightLine = !isLinux || !has("gui_running")
let full_vimrc = 1
" let useLightLine = 0

set nocompatible              " be iMproved, required

if filereadable(expand("~/.vimrc.plugins"))
    source ~/.vimrc.plugins
endif

" let comma be used as map leader
let mapleader=","
map \ ,

" use command-line window for commands
" nnoremap : q:i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => autocomplete hacks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " enter selects highlight in completion
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" " open completion and highlight first match
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" " open omnicomplete and highlight first match
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" " open omni completion menu closing previous if open and opening new menu without changing the text
" inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"             \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" " open user completion menu closing previous if open and opening new menu without changing the text
" inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"             \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => peekaboo command line hack
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has("gui_running")
  function! s:Peekaboo()
    call peekaboo#peek(1, 'ctrl-r',  0)
  endfunction

  let g:Cmd2_cmd_mappings = {
      \ 'Peekaboo': {'command': function('s:Peekaboo'), 'type': 'function'},
      \ }

  cmap <C-R> <Plug>(Cmd2)Peekaboo

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ultisnips settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" since the defautl trigger <tab> conflicts with YCM
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocomplete (YCM) settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_filetype_blacklist = {
  \ 'tagbar' : 1,
  \ 'qf' : 1,
  \ 'notes' : 1,
  \ 'markdown' : 1,
  \ 'unite' : 1,
  \ 'text' : 1,
  \ 'vimwiki' : 1,
  \ 'pandoc' : 1,
  \ 'infolog' : 1,
  \ 'mail' : 1
  \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => syntastic settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_checkers=['gcc']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Hack to get alt-alpha keys to work in terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Alt_hack_char(ch) abort
  exec "set <A-".a:ch.">=\e".a:ch
  exec "imap \e".a:ch." <A-".a:ch.">"
endfunction

" alt+alpha
let c='a'
while c <= 'z'
  call Alt_hack_char(c)
  let c = nr2char(1+char2nr(c))
endw

call Alt_hack_char('\')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => SimplyFold settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0
" let g:SimpylFold_fold_import = 0

autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar settigns
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagbar_left=1
let g:tagbar_autofocus=1

nnoremap <silent> yot :TagbarOpen fj<CR>
nnoremap <silent> cot :TagbarOpen fj<CR>
nnoremap <silent> yoj :TagbarOpen fjc<CR>
nnoremap <silent> coj :TagbarOpen fjc<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if has("multi_byte")
"   if &termencoding == ""
"     let &termencoding = &encoding
"   endif
"   set encoding=utf-8
"   setglobal fileencoding=utf-8
"   "setglobal bomb
"   set fileencodings=ucs-bom,utf-8,latin1
" endif

"Coloring for xterm
" if has("terminfo")
" "   set t_Co=256
"     set t_Sf=[3%p1%dm
"     set t_Sb=[4%p1%dm
" "     set t_AB=^[[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
" "     set t_AF=^[[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
" else
" "     set t_Co=256
"     set t_Sf=[3%dm
"     set t_Sb=[4%dm
" endif

if !has("gui_running")
  " disables background color erase
  set t_ut=
endif
colorscheme molokai

" enable true color
" if exists('+termguicolors')
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
" endif

" molokai settings
" let g:malokai_original = 1
let g:rehash256 = 1

" Highlight the column at 80 chars (all code should be inside the column)
highlight ColorColumn ctermbg=235 guibg=#2c2d27
" let &colorcolumn="80,".join(range(120,999),",")
let &colorcolumn="80"

" augroup hilight_long_text
"   autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
"   autocmd BufEnter * match OverLength /\%80v.*/
" augroup END

syntax on

"Information on the following setting can be found with
":help set
set tabstop=2
set softtabstop=2
" set autoindent
set shiftwidth=2  "this is the level of autoindent, adjust to taste
set ruler
set relativenumber "displays the relative number on the side (Ctrl+n to toggle)
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]
"set visualbell
" Uncomment below to make screen not flash on error
set vb t_vb=""

" removes 'press ENTER or type a command to continue'
set shortmess=atToOI
set report=0
set noerrorbells

set scrolljump=10

"My settings
set guioptions-=TaA  "remove toolbar from gui
set nowrap
set linebreak "when wrap IS set don't wrap in the middle of words
set mouse=a
set ttymouse=xterm2
set ignorecase
set smartcase
set showmatch
set showcmd
set autoread
set lazyredraw
set hidden
set backup
set cindent
set notitle
" set cinoptions=\(0 "indent arg lists
set incsearch   "move as we search
set hlsearch    "highlight the search results
set virtualedit=block
set comments=s1:/*,mb:\ *,elx:\ */
"set term=dtterm
set expandtab " Use spaces instead of tabs
set cmdheight=2 " Height of the command bar
set splitright " set splitbelow
set nofoldenable " open vim without folds
set ttimeoutlen=50 "set timeoutlen=50
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.gch,*.pyc,*.jpg,*.gif,*.png " Ignore compiled files
set fo-=t " remove menu from gvim
set completeopt=longest,menuone

set cinoptions=:0.5s,=0.5s,l1,g0.5s,h0.5s,N-s,t0,i0,(0,J1
"              |     |     |  |     |     |   |  |  |  +-- don't confuse JS object decls with labels
"              |     |     |  |     |     |   |  |  +-- indent from unclosed parens
"              |     |     |  |     |     |   |  +-- C++ base class decls and initializations
"              |     |     |  |     |     |   +-- indent function return type at margin
"              |     |     |  |     |     +-- indent inside C++ namespace
"              |     |     |  |     +-- places statements after C++ scope decls
"              |     |     |  +--  place C++ scope declarations
"              |     |     +-- align with case label instead of statement
"              |     +-- place statements after case label
"              +-- placement of case after switch statement

" ignore these suffixes when searching files with multiple matches
set suffixes=.back,~,.o,.info,.swp,.obj
" set suffixes=.back,~,.h,.o,.info,.swp,.obj

let g:netrw_special_syntax=1

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

set ttyfast

"how to display whitespace
" set listchars=tab:_\ ,trail:_,extends:>,precedes:<
set listchars=tab:_\ ,trail:_
set nolist

" disable alt for windows menu
set winaltkeys=no

" prefer diffs to be vertical
set diffopt=filler,vertical

" turn spell check on for git commit messages
autocmd Filetype gitcommit setlocal spell
autocmd Filetype hgcommit setlocal spell
autocmd Filetype markdown setlocal spell

"Set default diff
let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'

"set indent guide colors
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=darkblue
hi IndentGuidesEven ctermbg=lightgrey

" use mouse to select
behave mswin

" C syntax highlight settings
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bloomberg
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" give .mcfg xml filetype
au BufNewFile,BufRead *.mcfg,*.cfg set ft=xml

" Projmake settings
" -----------------

let g:useDispatch = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keyboard settings/key bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle relative numbers
nnoremap <silent> <C-n> :call ToggleRelative()<CR>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Pane navigation using Alt and arrow keys
nnoremap <M-left> <C-w><Left>
nnoremap <M-right> <C-w><right>
nnoremap <M-up> <C-w><up>
nnoremap <M-down> <C-w><down>

let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
noremap <silent> <M-h> :TmuxNavigateLeft<cr>
noremap <silent> <M-j> :TmuxNavigateDown<cr>
noremap <silent> <M-k> :TmuxNavigateUp<cr>
noremap <silent> <M-l> :TmuxNavigateRight<cr>
noremap <silent> <M-\> :TmuxNavigatePrevious<cr>

tnoremap <silent> <M-h> <C-w>:TmuxNavigateLeft<cr>
tnoremap <silent> <M-j> <C-w>:TmuxNavigateDown<cr>
tnoremap <silent> <M-k> <C-w>:TmuxNavigateUp<cr>
tnoremap <silent> <M-l> <C-w>:TmuxNavigateRight<cr>
tnoremap <silent> <M-\> <C-w>:TmuxNavigatePrevious<cr>

" Faster navigation wit ctrl
noremap <C-up> 10gk
noremap <C-down> 10gj
noremap <C-right> 5l
noremap <C-left> 5h

" Faster navigation witn ctrl
noremap <C-k> 10gk
noremap <C-j> 10gj
noremap <C-h> 5h
noremap <C-l> 5l

" 0 jumps to first non black char in line
noremap 0 ^

" Copy to clipboard
" vnoremap <C-c> "*y

" Cut to clipboard
" vnoremap <C-x> "*c

" Paste from the clipbaord
" vnoremap <C-v> c<ESC>"*p
" inoremap <C-v> <ESC>"*pa
" nnoremap <C-v> "*p

" Move to next resent and put it in the middle of the split
noremap <silent> n nzz
noremap <silent> N Nzz

" quickly exit insert mode without esc
inoremap fj <Esc>
vnoremap fj <Esc>
snoremap fj <Esc>

" highlight all matched under cursor but don't jump to next match
nnoremap * :keepjumps normal! mi*`i<CR>

" more natural navigation of log lines with word wrap
nnoremap j gj
nnoremap k gk

" ------------------------------
"           TAB MODES
" ------------------------------

" switch between tab modes
nnoremap <leader><leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nnoremap <leader><leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nnoremap <leader><leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nnoremap <leader><leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" tab modes for file types
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype go setlocal noexpandtab ts=4 sts=4 sw=4
autocmd Filetype make setlocal noexpandtab

" switch between paste modes (use unimpaired co* style)
" event though tpope disagrees with paste mode having shortcut
" tpope probably doesn't use putty like I am.
nnoremap cop :set paste!<CR>

"more co-* commands
nnoremap cog :IndentGuidesToggle<CR>
nnoremap coe :call ToggleList("Quickfix List", 'c')<CR>
nnoremap coll :call ToggleList("Location List", 'l')<CR>

"Map F4 to toggle search results highlights
nnoremap <silent> <F4> :set hlsearch!<CR>

" Toggle a diff view comparing unsaved changes to saved version
nnoremap <silent> <S-F4> :DiffChangesDiffToggle<CR>

"Toggle for showing whitespace
" noremap <C-k>l :set list!<CR>

"Toggle scrollbinding on all windows
" nnoremap <C-k>s :windo set scrollbind!<CR>

"use cmd2 mode
" nmap : :<F12>
" nmap / /<F12>
cmap <F12> <Plug>(Cmd2Suggest)

" Clang format
" ------------
nnoremap <leader>cf <Plug>(operator-clang-format)

" Cmd2 settings
" -------------

cnoremap <key> <nop>

let g:Cmd2_options = {
          \ '_complete_ignorecase': 1,
          \ '_complete_uniq_ignorecase': 0,
          \ '_complete_fuzzy': 1,
          \ }

" cmap <expr> <Tab> Cmd2#ext#complete#InContext() ? "\<Plug>(Cmd2Complete)" : "\<Tab>"

set wildcharm=<Tab>

" Easy Motion settings
" --------------------

map <Leader> <Plug>(easymotion-prefix)

" Line motions
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" use easy motion for searching and navigation
" map  / <plug>(easymotion-sn)
" omap / <plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

let g:EasyMotion_wrapscan = 1 " enable search wrapping around end of file

let g:EasyMotion_startofline = 0 " Disable keep cursor colum when JK motion

let g:EasyMotion_do_mapping = 0 " Disable default mappings

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Font settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
  if isLinux
    "linux is capable of using source code pro
    set gfn=Source\ Code\ Pro\ Medium\ Semi-Bold\ 14
    set gfw=Source\ Code\ Pro\ Black\ Regular\ 14

  else
    if has("gui_gtk2")
      set guifont=Courier\ New\ 18
    elseif has("gui_photon")
      set guifont=Courier\ New:s16
    elseif has("gui_kde")
      set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
    elseif has("x11")
      set guifont=-*fixed-medium-r-*-*-*-140-*-*-*-*-*-*
    else
      set guifont=Courier_New:h11:cDEFAULT
    endif
    "if has("terminfo")
    "elsge
    "endif
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " OpenGrok by pressing K (only works on linux)
" if isLinux
"     nnoremap <silent> K :!firefox code.dev.bloomberg.com/opengrok/search?q=<cword> &<CR><CR>
" endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show air-line (even when there isn't a split)
set laststatus=2

"-------------------------
"  Lightline settings
  let g:lightline = {
    \ 'enable': {
      \     'statusline': 1,
      \     'tabline': 1
      \ },
    \ 'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'filename', 'modified' ],
      \           [ 'fugitive' ] ],
      \     'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'filetype' ] ]
      \ },
    \ 'inactive': {
      \     'left': [ [ 'filename' ] ],
      \     'right': [ [ 'lineinfo' ],
      \            [ 'percent' ] ] },
    \ 'tabline': {
      \    'left': [ [ 'tabs' ] ],
      \    'right': [ [ 'close' ] ],
      \ },
    \ 'colorscheme' : 'default',
    \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"x":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fileencoding': '',
      \   'fileformat': ''
      \ },
    \ 'component_visible_condition' : {
      \   'fileencoding': 0,
      \   'fileformat': 0,
      \ },
    \ 'component_function': {
      \   'fugitive': 'LightlineFugitive'
      \ },
    \ }

  let g:lightline.mode_map = {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'v' : 'v',
      \ 'V' : 'V',
      \ 'c' : 'C',
      \ "\<C-v>": 'V',
      \ 's' : 's',
      \ 'S' : 'S',
      \ "\<C-s>": 'S',
      \ '?': ' ',
      \ 't': 'T' }
" Light line functions
" --------------------

function! LightlineFugitive() abort
  if &filetype ==# 'help'
    return ''
  endif
  if has_key(b:, 'lightline_fugitive') && reltimestr(reltime(b:lightline_fugitive_)) =~# '^\s*0\.[0-5]'
    return b:lightline_fugitive
  endif
  try
    if exists('*fugitive#head')
      let head = fnamemodify(fugitive#head(), ":t")
    else
      return ''
    endif
    let b:lightline_fugitive = head
    let b:lightline_fugitive_ = reltime()
    return b:lightline_fugitive
  catch
  endtry
  return ''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => settings for improving CtrlP functionality
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PyMatcher for CtrlP
if !has('python') && !has('python3')
  echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Auto commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " Python pylint
" autocmd FileType python set makeprg=python3.6\ -m\ pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
" autocmd FileType python set errorformat=%f:%l:\ %m

" Highlight line
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"auto reload vimrc when it changes
"and reload airline
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
    " autocmd BufWritePost ~/.local/.vimrc nested source $MYVIMRC
augroup END " }

" cleanup vim-fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" cleanup whitespace when closing a file
autocmd BufWritePre * if &ft != "sh" | call StripTrailingWhitespace()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands for command line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! RemoveTrailingWhiteSpace call StripTrailingWhitespace()
command! -nargs=1 -complete=file Vdiff call OpenDiffTab(<f-args>)
command! ToggleScrollBind set scb! " I always forget this command. This shculd make it easier
command! CommentConfig silent %s/^\(.\)/# \1/g | nohlsearch
command! UncommentConfig silent %s/^# //g | nohlsearch

" puts rcsid info in a file
command! UpdateHeader !update_rcsid -a --nobackup %

" Custom grok search commands
command! -bang -nargs=1 Oib call vimgrok#search(<bang>0, '-p', "(bbgithub ib-*) || (bbgithub cc-*) || (devgit ib)", '-f', <f-args>)
command! -bang -nargs=1 Olib call vimgrok#lsearch(<bang>0, '-p', "(bbgithub ib-*)  || (bbgithub cc-*) || (devgit ib)", '-f', <f-args>)
command! -bang -nargs=1 Oibdef call vimgrok#search(<bang>0, '-p', "(bbgithub ib-*) || (bbgithub cc-*) || (devgit ib)", '-d', <f-args>)
command! -bang -nargs=1 Olibdef call vimgrok#lsearch(<bang>0, '-p', "(bbgithub ib-*) || (bbgithub cc-*) || (devgit ib)", '-d', <f-args>)
command! -bang -nargs=1 Occ call vimgrok#search(<bang>0, '-p', "(bbgithub ib-*) || (bbgithub cc-*) || (devgit ib)", '-f', <f-args>)
command! -bang -nargs=1 Olcc call vimgrok#lsearch(<bang>0, '-p', "(bbgithub ib-*)  || (bbgithub cc-*) || (devgit ib)", '-f', <f-args>)
command! -bang -nargs=1 Occdef call vimgrok#search(<bang>0, '-p', "(bbgithub ib-*) || (bbgithub cc-*) || (devgit ib)", '-d', <f-args>)
command! -bang -nargs=1 Olccdef call vimgrok#lsearch(<bang>0, '-p', "(bbgithub ib-*) || (bbgithub cc-*) || (devgit ib)", '-d', <f-args>)

nnoremap oga :call vimgrok#search(0, '-f', expand("<cword>"))<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Merge helpers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! Mleft diffget //2 | diffup
command! Mright diffget //3 | diffup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! OpenDiffTab(diffFile)
  "first open the current buffer into a new tab"
  execute "tab sp"
  "then do the diff
  execute "vertical diffsplit " . a:diffFile
endfunction

function! StripTrailingWhitespace()
  let l:ignore = [ 'diff',
                 \ 'qf',
                 \ 'help',
                 \ ]

  if !&binary && !&readonly && (index(l:ignore, &filetype) < 0)
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Used for toggling quick fix window
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  " these commented winnr commands keep focus in original window
  " let winnr = winnr()
  exec('botright '.a:pfx.'open')
  "  if winnr() != winnr
  "    wincmd p
  "  endif
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif

    return ''
endfunction

" Toggle relative line numbers
function! ToggleRelative()
    if (&rnu == 1)
        set nu
        set nornu
    else
        set nonu
        set rnu
    endif
endfunction

" Source local override file if one exists.
if filereadable(expand("~/.local/.vimrc"))
    source ~/.local/.vimrc
endif
