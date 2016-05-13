let os = system("uname")
let isLinux = (os == "Linux\n")
let useAirline = has("gui_running") && isLinux
" let useAirline = isLinux
let useLightLine = !isLinux || !has("gui_running")
" let useLightLine = 0
" let useAirlineFont = has("gui_running")

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

  " let Vundle manage Vundle, required
  Plugin 'gmarik/Vundle.vim'

  " Vundles
  " =======
  
  " sensible default settings
  " -------------------------
  Plugin 'tpope/vim-sensible'

  " colorschemes
  " -------------
  Plugin 'nanotech/jellybeans.vim'
  Plugin 'tomasr/molokai'
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'chriskempson/vim-tomorrow-theme'

  " colorscheme support for command line
  " ------------------------------------
"   Plugin 'colorsupport.vim'

  " file navigation
  " ---------------
  "Plugin 'scrooloose/nerdtree'
  Plugin 'kien/ctrlp.vim'
  Plugin 'FelikZ/ctrlp-py-matcher'
  Plugin 'tpope/vim-vinegar'
  "Plugin 'majutsushi/tagbar'
  Plugin 'mileszs/ack.vim'
  Plugin 'Lokaltog/vim-easymotion'
  Plugin 'kien/tabman.vim'
  Plugin 'a.vim'
  Plugin 'tpope/vim-unimpaired'

  " Split navigation with tmux
  " --------------------------
  Plugin 'christoomey/vim-tmux-navigator'

  " syntax
  " ------
  Plugin 'tpope/vim-git'
  " Plugin 'scrooloose/syntastic'

  " source control
  " --------------
  Plugin 'tpope/vim-fugitive'
  Plugin 'vim-scripts/diffchanges.vim'
  Plugin 'buchmoyerm/vim-diff-enhanced'
  Plugin 'airblade/vim-gitgutter'

  " other
  " ----
"   Plugin 'closetag.vim'
  Plugin 'tpope/vim-dispatch'
  Plugin 'gorkunov/smartpairs.vim'
  Plugin 'nathanaelkane/vim-indent-guides'
  Plugin 'tpope/vim-repeat'

  " UNIX helpers
  " ------------
  Plugin 'tpope/vim-eunuch'
  Plugin 'tpope/vim-commentary'
  
  " Bloomberg
  " ---------
  Plugin 'file:///home/mbuchmoyer/mbig/dev/vim/projmake.vim'
"   Plugin 'ssh://bbgithub.dev.bloomberg.com/mbuchmoyer/bbprojmake.vim.git'

  " peekaboo needs Cmd2 hack to work on commandline
  Plugin 'junegunn/vim-peekaboo'
  Plugin ('gelguy/Cmd2.vim')

  " platform specific plugins
  " -------------------------
  if useAirline
    Plugin 'bling/vim-airline'
  elseif useLightLine
    Plugin 'itchyny/lightline.vim'
  endif

  if has("unix")
    if !v:shell_error && isLinux
      Plugin 'Valloric/YouCompleteMe'
    endif
  endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on    " required

" let comma be used as map leader
let mapleader=","
map \ ,


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
" => Autocomplete (YCM) settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Addition config for YouCompleteMe
if has("unix")
  if !v:shell_error && isLinux
    nnoremap <silent> <F12> :YcmCompleter GoTo<CR>
    "let g:ycm_global_ycm_extra_conf = '/bb/mbigd/mbig1265/.ycm_extra_conf.py'
    let g:ycm_path_to_python_interpreter = '/opt/swt/bin/python2.7'
    "let g:ycm_path_to_python_interpreter = '/bb/bin/bbpy2.7'
    "
    "let g:ycm_filetype_whitelist = { 'cpp': 0, 'py': 1, 'h': 0}


    let g:ycm_server_keep_logfiles = 1
    "let g:ycm_server_log_level = 'debug'
    "let g:ycm_key_list_select_completion = ['<Tab>', '<Down>']
    "let g:ycm_confirm_extra_conf = 0
    "let g:ycm_server_use_vim_stdout = 1
    let g:ycm_global_ycm_extra_conf = '/home/mbuchmoyer/.vim/config/.config_extra_conf.py'

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
  endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => syntastic settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_checkers=['gcc']

let g:syntastic_cpp_include_dirs = ['/bb/build/Linux-x86_64-64/release/robolibs/prod/lib/dpkgroot/opt/bb/include/', '/bb/build/Linux-x86_64-64/release/robolibs/weekly/share/include/00depbuild/', '/bb/build/Linux-x86_64-64/release/robolibs/weekly/share/include/00deployed/', '/bb/build/Linux-x86_64-64/release/robolibs/weekly/share/include/00offlonly/', '/bb/build/share/stp/include/00depbuild/', '/bb/build/share/stp/include/00deployed/', '/bb/build/share/stp/include/00offlonly/']

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
" => VIM settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8

"Coloring for xterm
if has("terminfo")
   set t_Co=256
    set t_Sf=[3%p1%dm
    set t_Sb=[4%p1%dm
"     set t_AB=^[[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
"     set t_AF=^[[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
else
"     set t_Co=256
    set t_Sf=[3%dm
    set t_Sb=[4%dm
endif

if !has("gui_running")
  " disables background color erase
  set t_ut=
endif
colorscheme molokai

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
set whichwrap+=<,>,h,l
"set visualbell
" Uncomment below to make screen not flash on error
set vb t_vb=""

" removes 'press ENTER or type a command to continue'
set shortmess=atI

"My settings
set guioptions-=T  "remove toolbar from gui
set nowrap
set mouse=a
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

" ignore these suffixes when searching files with multiple matches
set suffixes=.back,~,.o,.info,.swp,.obj
" set suffixes=.back,~,.h,.o,.info,.swp,.obj

set fo-=t

let g:netrw_special_syntax=1

"set timeoutlen=50
set ttimeoutlen=50

set wildmenu
set wildmode=list:longest,full

" Ignore compiled files
set wildignore=*.o,*~,*.gch,*.pyc,*.jpg,*.gif,*.png

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Height of the command bar
set cmdheight=2

set ttyfast

"how to display whitespace
set list listchars=tab:>-,trail:.
set nolist

" set splitbelow
set splitright

" prefer diffs to be vertical
set diffopt=filler,vertical

" turn spell check on for git commit messages
autocmd Filetype gitcommit setlocal spell

"Set default diff
let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'

"set indent guide colors
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=darkblue
hi IndentGuidesEven ctermbg=lightgrey
" let g:indent_guides_guide_size = 1

" use mouse to select
behave mswin

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

" disable alt for windows menu
set winaltkeys=no

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

" nnoremap <M-j> <C-w>j
" nnoremap <M-k> <C-w>k
" nnoremap <M-l> <C-w>l
" nnoremap <M-h> <C-w>h

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
noremap <silent> <M-h> :TmuxNavigateLeft<cr>
noremap <silent> <M-j> :TmuxNavigateDown<cr>
noremap <silent> <M-k> :TmuxNavigateUp<cr>
noremap <silent> <M-l> :TmuxNavigateRight<cr>
noremap <silent> <M-\> :TmuxNavigatePrevious<cr>

" git gutter mappings
let g:gitgutter_map_keys = 0
nmap <leader>gs <Plug>GitGutterStageHunk
nmap <leader>gu <Plug>GitGutterRevertHunk
nmap <leader>gv <Plug>GitGutterPreviewHunk
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk

" Windows-like find all
nnoremap <C-F> :Ack!<Space>

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

" Toggle tagbar;
nnoremap <silent> <F8> :TagbarToggle<CR>

" 0 jumps to first non black char in line
noremap 0 ^

" refresh all open buffers based on file mod time
noremap <C-F5> :checktime<CR>

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

noremap <leader><F2> :call StripTrailingWhitespace()<CR>

" quickly exit insert mode without esc
inoremap fj <Esc>
vnoremap fj <Esc>
snoremap fj <Esc>

" highlight all matched under cursor but don't jump to next match
nnoremap * :keepjumps normal! mi*`i<CR>

" more natural navigation of log lines with word wrap
nnoremap j gj
nnoremap k gk

" switch between tab modes
nnoremap <leader><leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nnoremap <leader><leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nnoremap <leader><leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nnoremap <leader><leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" switch between wrap modes
nnoremap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

" switch between paste modes (use unimpaired co* style)
" event though tpope disagrees with paste mode having shortcut
" tpope probably doesn't use putty like I am.
nnoremap cop :set paste!<CR>

"more co-* commands
nnoremap cog :IndentGuidesToggle<CR>
nnoremap coe :call ToggleList("Quickfix List", 'c')<CR>

"Map F4 to toggle search results highlights
nnoremap <silent> <F4> :set hlsearch!<CR>

" Toggle a diff view comparing unsaved changes to saved version
nnoremap <silent> <S-F4> :DiffChangesDiffToggle<CR>

"Toggle for showing whitespace
noremap <C-k>l :set list!<CR>

"Toggle scrollbinding on all windows
nnoremap <C-k>s :windo set scrollbind!<CR>

"use cmd2 mode
" nmap : :<F12>
" nmap / /<F12>
cmap <F12> <Plug>(Cmd2Suggest)

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

let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

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

" set statusline+=[%{&fo}]
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
"   set statusline+=%*


if useAirline

"   "toggle showing whitespace or not
  noremap <silent> <C-k><C-w> :AirlineToggleWhitespace<CR>

  let g:airline_section_y = ''  " don't show file encoding
  let g:airline#extensions#tabline#enabled = 1 "enable tabline
  let g:airline#extensions#whitespace#enabled = 0  " don't show whitespace default
  let g:airline#extensions#tabline#show_buffers = 0 " don't show buffer line
"   let g:airline#extensions#bufferline#enabled = 0 " don't show buffer line
  let g:airline#extensions#branch#format = 1 " show just the tail of the the branch

  " load font for glyphs
"   let g:airline_powerline_fonts = 1

"   let g:Powerline_symbols = 'fancy'

  if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif
  let g:airline_symbols.space = "\ua0"

  let g:airline_left_sep=''
  let g:airline_right_sep=''

  " Set the text to display in each mode (take up less space)
  let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

elseif useLightLine

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
    \ 'colorscheme' : 'wombat',
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

" 		let g:lightline.mode_map = {
" 		    \ 'n' : 'NORMAL',
" 		    \ 'i' : 'INSERT',
" 		    \ 'R' : 'REPLACE',
" 		    \ 'v' : 'VISUAL',
" 		    \ 'V' : 'V-LINE',
" 		    \ 'c' : 'COMMAND',
" 		    \ "\<C-v>": 'V-BLOCK',
" 		    \ 's' : 'SELECT',
" 		    \ 'S' : 'S-LINE',
" 		    \ "\<C-s>": 'S-BLOCK',
" 		    \ '?': '      ' }

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
      \ '?': ' ' }
" Light line functions
" --------------------

" function! LightLineFilename() abort
"   return expand('%')
" endfunction

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
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => settings for improving CtrlP functionality
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PyMatcher for CtrlP
if !has('python')
  echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Auto commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight line
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Commenting blocks of code.
" augroup CommentLine
"   autocmd!
"   autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
"   autocmd FileType sh,ruby,python   let b:comment_leader = '# '
"   autocmd FileType conf,fstab       let b:comment_leader = '# '
"   autocmd FileType tex              let b:comment_leader = '% '
"   autocmd FileType mail             let b:comment_leader = '> '
"   autocmd FileType vim              let b:comment_leader = '" '
" augroup END
" noremap <silent> <C-k><C-c> :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
" noremap <silent> <C-k><C-u> :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

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
    if useAirline
      autocmd BufWritePost $MYVIMRC execute 'AirlineRefresh'
    endif
augroup END " }

" cleanup vim-fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands for command line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! RemoveTrailingWhiteSpace call StripTrailingWhitespace()
command! -nargs=1 -complete=file Vdiff call OpenDiffTab(<f-args>)
command! ToggleScrollBind set scb! " I always forget this command. This should make it easier
command! CommentConfig silent %s/^\(.\)/# \1/g | nohlsearch
command! UncommentConfig silent %s/^# //g | nohlsearch

" puts rcsid info in a file
command! UpdateHeader !update_rcsid -a --nobackup %

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
  if !&binary && &filetype != 'diff'
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

command! FreeLibs call AddFreeLibs()<cr>

function! AddFreeLibs()
    r~/free_libs.txt
endfunction
