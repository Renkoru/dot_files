" Need to call on initially to support git
filetype on
filetype off
set nocompatible

filetype indent plugin on
syntax on

" Autoload 'junegunn/vim-plug' plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Plugins conf. Plugin manager - 'junegunn/vim-plug'
call plug#begin('~/.vim/plugged')

" https://github.com/jameslai/jvim/blob/master/vimrc
" original repos on github
" Plug 'Raimondi/delimitMate'

" Vim system
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired' " TODO: Explore all possibilities of this plugin.
Plug 'mhinz/vim-startify' " TODO: Explore this plugin
Plug 'elzr/vim-json'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/limelight.vim' " Do I need this plugin?
Plug 'junegunn/goyo.vim'
" =========== {
let g:goyo_width = 150
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
" let g:goyo_linenr = 0
" }

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" =========== {
let NERDTreeIgnore=['\.pyc$']
" }
"
Plug 'majutsushi/tagbar'
" =========== {
let g:tagbar_autofocus=1
let g:tagbar_autoclose=1
let g:tagbar_sort=0			"tagbar shows tags in order of they created in file
let g:tagbar_foldlevel=0	"close tagbar folds by default
" }
"
Plug 'bling/vim-airline'
" =========== {
let g:airline_section_z = ''
let g:airline#extensions#tabline#enabled = 1
" Remove indent and trailing detection.
let g:airline#extensions#whitespace#checks = []
let g:airline#extensions#branch#displayed_head_limit = 13
let g:airline#extensions#branch#format = 1
" let g:airline_powerline_fonts = 1
" }

Plug 'scrooloose/syntastic'
" =========== {

" Use :Errors instead.
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'passive',
                          \ 'active_filetypes': ['javascript'],
                          \ 'passive_filetypes': [] }
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers = ['pep8', 'pyflakes']
let g:syntastic_python_pep8_args = "--ignore=E501"
let g:syntastic_python_pylint_post_args = '--disable=C0111'
let g:syntastic_javascript_checkers = ['jshint']
" }

Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
" =========== {
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'


let g:vimfiler_no_default_key_mappings = 1 
" }

Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/unite-outline'
" Need tsukkee/unite-tag for :Unite tag
Plug 'tsukkee/unite-tag'

"Code complete. Fast conding {{{
"
" Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
" let g:ycm_add_preview_to_completeopt = 0
" let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_complete_in_comments = 1
" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_key_list_select_completion = ['<TAB>', '<C-j>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
" let g:ycm_path_to_python_interpreter = '/home/mrurenko/.virtualenvs/doc_search/local/bin/python'

Plug 'Shougo/neocomplete.vim'
" =========== {
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplete#max_list = 20
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Setting for python and jedi
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

" Setting for python and jedi
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
" let g:neocomplete#force_omni_input_patterns.python =
" 			\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
set completeopt-=preview

" Neocomplete key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"


" AutoComplPop like behavior.
" let g:neocomplete#enable_auto_select = 1

" Fix for Multiple cursors
function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
    echo 'Disabled autocomplete'
endfunction

function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
    echo 'Enabled autocomplete'
endfunction
" }

Plug 'Shougo/neosnippet.vim'
" =========== {
" Plugin key-mappings.
imap <A-k>     <Plug>(neosnippet_expand_or_jump)
smap <A-k>     <Plug>(neosnippet_expand_or_jump)
xmap <A-k>     <Plug>(neosnippet_expand_target)
" }

Plug 'Shougo/neosnippet-snippets'
" My snippets
Plug 'Rumra/rumra-vim-snippets'
Plug 'honza/vim-snippets'

Plug 'SirVer/ultisnips'
" =========== {
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsExpandTrigger="<A-c>"

" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsJumpForwardTrigger="<A-c>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsSnippetDirectories=["UltiSnips", './plugged/rumra-vim-snippets']
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" }


" Code complete. Fast coding }}}

" Syntax plugins
" Plug 'tpope/vim-haml', { 'for': ['scss', 'sass', 'haml'] }
" Plug 'tpope/vim-markdown', { 'for': 'markdown' }
" Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
" Plug 'othree/html5-syntax.vim', { 'for': 'html' }
" Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
" Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
" Plug 'jiangmiao/simple-javascript-indenter', { 'for': 'javascript' }
" Plug 'groenewege/vim-less', { 'for': 'less' }
" Plug 'evanmiller/nginx-vim-syntax', { 'for': 'nginx' }

" Automated sytax highliting
" Plug 'xolox/vim-misc' " TODO: Explore this plugin
" Plug 'xolox/vim-easytags' " TODO: Explore this plugin


"Python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" =========== {
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
" }

" Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }

" Plug 'klen/python-mode'
" let g:pymode_rope_completion = 0
" let g:pymode_rope_complete_on_dot = 0
" let g:pymode_completion_provider = 'jedi'
" let g:pymode_syntax_highlight_equal_operator = 0
" let g:pymode_folding = 0
" let g:pymode_virtualenv = 1
" let g:pymode_lint_ignore = "E501,E128,C901,"
" let g:pymode_lint_cwindow = 1

" Javascript
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' } " TODO: Explore this plugin
Plug 'pangloss/vim-javascript', { 'for': 'javascript' } " TODO: Explore this plugin

" VCS Git
Plug 'tpope/vim-fugitive'
" Need vim-fugitive
Plug 'gregsexton/gitv' " TODO: Explore this plugin
Plug 'airblade/vim-gitgutter'
" =========== {
let g:gitgutter_enabled = 0
" Disable gutgutter key maps. Map them by myself.
let g:gitgutter_map_keys = 0
" }

" % more usefull, html.
" Plug 'matchit.zip', { 'for': ['html', 'xml'] }
" Plug 'gregsexton/MatchTag'
Plug 'sukima/xmledit', { 'for': ['html', 'xml'] }
Plug 'amirh/HTML-AutoCloseTag', { 'for': ['html', 'xml'] }

" Code formating
Plug 'sjl/gundo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors' " Fast coding. TODO: Explore all possibilities of this plugin.
Plug 'tommcdo/vim-exchange'
Plug 'mattn/emmet-vim', { 'for': ['html', 'xml'] }
Plug 'osyo-manga/vim-over' " TODO: Explore this plugin

" Code movement
Plug 'Lokaltog/vim-easymotion'
" =========== {
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
" }

Plug 'kshenoy/vim-signature'

" Visual Plugins
Plug 'nathanaelkane/vim-indent-guides'
" =========== {
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_color_change_percent = 3
" }

" Good view
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'ntpeters/vim-better-whitespace'
" =========== {
let g:better_whitespace_filetypes_blacklist = ['unite']
" }

" let g:better_whitespace_filetypes_blacklist=['unite', '<filetype2>', '<etc>']
" }
" Plug 'altercation/vim-colors-solarized'
" Plug 'flazz/vim-colorschemes'
Plug 'digitaltoad/vim-jade', { 'for': 'jade' } " TODO: I need it? check.
Plug 'mattn/emmet-vim', { 'for': ['html', 'xml'] }


call plug#end()

" Neocomplete settings
call neocomplete#custom#source('buffer', 'rank', 10)
call neocomplete#custom#source('tag', 'rank', 9)

" solarized, badwolf, luna, gruvbox
colorscheme seoul256
set background=light


" General vim settings #############################################################################################

" Highlight functions using Java style
let java_highlight_all=1
" let java_highlight_functions="style"


" Keymaps ##############################################################################################
" let mapleader = ","
let g:mapleader = "\<Space>"
nnoremap <F2> :Goyo<CR>
nmap <silent> <F3> :NERDTreeToggle<CR>
nnoremap <F4> :VimFiler -winwidth=1 -toggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F9> :CtrlPMixed<CR>
nnoremap <F11> :CtrlPMRUFiles<CR>
nnoremap <F5> :SyntasticCheck<CR>
" toggle gundo
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

nnoremap tn :tabnew<CR>

" Git maps
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gs :Gstatus<CR>

" VimFiler maps

" nnoremap L gt
nnoremap tg gT

" Easy-align maps
vmap <Leader>t <Plug>(EasyAlign)
nmap <Leader>t <Plug>(EasyAlign)

" EasyMotion maps
nmap <Leader>s <Plug>(easymotion-s2)

" JK motions: Line motions
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" Toggle
" GutGutter maps
nnoremap cog :GitGutterToggle<CR>
nnoremap cogs :GitGutterSignsToggle<CR>
nnoremap cogl :GitGutterLineHighlightsToggle<CR>
nnoremap <Leader>ghv <Plug>GitGutterPreviewHunk

nnoremap <Leader>` :nohlsearch<CR>
" по звездочке не прыгать на следующее найденное, а просто подсветить
nnoremap * *N

" Clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>y "+y

" move to beginning of line
nnoremap B ^
vnoremap B ^

" Switch between buffers (Like Alt-Tab)
nnoremap <A-b> <C-^>

" $/^ doesn't do anything
nnoremap ^ <nop>
vnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" jk is escape
inoremap jk <esc>

" Move lines
nmap <A-j> ]e
nmap <A-k> [e
vmap <A-j> ]egv
vmap <A-k> [egv

" Resize (expand) windows
nnoremap <C-w>h 6<C-W><
nnoremap <C-w>j 5<C-W>+
nnoremap <C-w>k 5<C-W>-
nnoremap <C-w>l 6<C-W>>

" Switch W
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap <Leader>- <C-w>_
nnoremap <Leader>= <C-w>=


" " Commands
" " CDC = Change all windiws working directories to Directory of Current file
" command CDC cd %:p:h
" " LCDC = Change local window working directories to Directory of Current file
" command LCDC lcd %:p:h

" Unite settings
let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#filters#sorter_default#use(['sorter_rank'])

" call unite#custom#source(
"             \ 'buffer,file_rec/async,file_rec,file_mru', 'converters',
"             \ ['converter_smart_path'])

call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep',
            \ 'ignore_pattern', join([
            \ '\.git',
            \ '\.metadata',
            \ '\.svn',
            \ '\.sass-cache',
            \ 'vendor',
            \ 'env',
            \ 'node_modules',
            \ '.class',
            \ ], '\|'))

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

call unite#custom#source(
            \ 'buffer,file_rec/async,file,file_rec,file_mru', 'converters',
            \ 'converter_file_directory')

call unite#custom#source(
            \ 'jump', 'converters',
            \ 'converter_tail')

" sort file results by length
call unite#custom#source(
            \ 'buffer,file_rec/async,file_rec,file,file_mru,jump', 'sorters',
            \ 'sorter_rank')

" call unite#custom#source('file', 'sorters', 'sorter_length')
" call unite#custom#source('file_rec/async', 'sorters', 'sorter_length')

let g:unite_source_file_rec_max_cache_files = 0
call unite#custom#source('file,file_rec,file_rec/async',
            \ 'max_candidates', 20)

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  let b:SuperTabDisabled=1

  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
  imap <buffer> <c-a> <Plug>(unite_choose_action)

  imap <silent><buffer><expr> <C-s> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

" The prefix key
nnoremap [unite] <Nop>
nmap , [unite]

" General purpose
nnoremap [unite]<space> :Unite -no-split -start-insert source<cr>

" Files
nnoremap [unite]f :Unite -no-split -start-insert file_rec/async<cr>

" Grepping
nnoremap [unite]g :Unite -no-split grep:.<cr>
nnoremap [unite]d :Unite -no-split grep:.:-s:\(TODO\|FIXME\)<cr>

 " Content
nnoremap [unite]o :Unite -no-split -start-insert outline<cr>
nnoremap [unite]l :Unite -no-split -start-insert line<cr>
" nnoremap [unite]t :!retag<cr>:Unite -no-split -auto-preview -start-insert tag<cr>

" Quickly switch between recent things
nnoremap [unite]F :Unite -no-split -start-insert buffer tab file_mru directory_mru<cr>
nnoremap [unite]b :Unite -no-split -start-insert buffer<cr>
nnoremap [unite]c :Unite -start-insert -direction=botright buffer<CR>
nnoremap [unite]m :Unite -start-insert -no-split file_mru<cr>
nnoremap [unite]; :UniteWithBufferDir
			\ -start-insert -direction=botright -buffer-name=jumps jump<CR>

" Yank history
nnoremap [unite]y :Unite -direction=botright history/yank<cr>

" Bookmarks
nnoremap [unite]r :UniteBookmarkAdd<cr>
nnoremap [unite]rl :Unite -no-split -start-insert bookmark<cr>


" >====================== End of Unite settings ====================================<
if has('multi_byte')
    if version >= 700
        " set listchars=tab:»\ ,trail:·,eol:¶,extends:→,precedes:←,nbsp:×
        set listchars=tab:▸\ ,eol:¬ " TextMate
    else
        set listchars=tab:»\ ,trail:·,eol:¶,extends:>,precedes:<,nbsp:_
    endif
endif


set autoread

" MY ADDINGS
" задать размер табуляции в четыре пробела
set tabstop=4
" set softtabstop=4
set shiftwidth=4
set smarttab
" Spaces instead tabs
set expandtab

" Automatically attempt to handle indentation
set autoindent
set smartindent

" Line number rules
" set number
" set relativenumber
" set rnu

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Display the current mode at the bottom of the window
set showmode

" Extra information about the command you're running in the status bar
set showcmd
set hidden

" Auto complete filenames when in :Ex mode, etc
"set wildmenu" enables a menu at the bottom of the vim/gvim window.
set wildmenu
set wildmode=list:longest

set lazyredraw          " redraw only when we need to.

set visualbell
set cursorline
set ttyfast

" Always show the status line
set laststatus=2

" Initially ignore cases in searches
set ignorecase

" Smart case searching. Case insensitive if all lowercase, but if you
" provide uppercase it will force matching case
set smartcase

" Support incremental searches (searching while you type)
set incsearch

" Highlight search results
set hlsearch

" Visually display matching braces
set showmatch

" Don't wrap
set nowrap

set textwidth=150
set formatoptions=qrn1

" Prevent goofy backup files
set nobackup

" Prevent the creation of swp files, they're just a mess
set noswapfile

" минимальная высота окна пусть будет 0 (по умолчанию - 1)
"set winminheight=10
" всегда делать активное окно максимального размера
set noequalalways
set winheight=10

if has('gui_running')
  set go-=m	" Hide menu += to show
  set go-=r	" Hide right scrollbar
  set go-=R	" Hide ^ when splits
  set go-=l	" ^ left scrollbar
  set go-=L	" ^ splits
  set go-=T	" Hide Toolbar
  set guifont=Source\ Code\ Pro\ 10
  set lines=50 columns=250
endif

set encoding=utf-8                                  " set charset translation encodingset termencoding=utf-8
set termencoding=utf-8  							" set terminal encoding
set fileencoding=utf-8                              " set save encoding
set fileencodings=utf8,koi8r,cp1251,cp866,ucs-2le   " список предполагаемых кодировок, в порядке предпочтения

" по умолчанию - латинская раскладка
set iminsert=0
" по умолчанию - латинская раскладка при поиске
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

"" ================ Folds ============================

set foldmethod=manual   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default set foldenable
" set foldlevelstart=1   " open most folds by default
" set foldnestmax=1      " 10 nested fold max
" set foldmethod=manual  " fold based on indent level
" syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
" syn region foldJavadoc start=,/\*\*, end=,\*/, transparent fold keepend extend

augroup vimrc_autocmds
    autocmd!
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS shiftwidth=2
    autocmd FileType scss setlocal  shiftwidth=2
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS shiftwidth=2
    autocmd FileType jade setlocal shiftwidth=2
	" Settings in jedi section
    " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd GUIEnter * set vb t_vb= " for your GUI ( screen not blinking now)
    autocmd VimEnter * set vb t_vb=
	" Remove trailing (spaces at end of the line) before write file.
    " autocmd BufWritePre * :%s/\s\+$//e

    " autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
    "В .py файлах включаем умные отступы после ключевых слов
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif

    " tpope/vim-commentary
    " You just have to adjust 'commentstring' to change comment type
    autocmd FileType apache setlocal commentstring=#\ %s
    autocmd FileType jsp setlocal commentstring=<\%--\ %s\ --\%>

    " Expand tab
    " autocmd FileType python setlocal expandtab softtabstop=4
	autocmd FileType python setlocal omnifunc=jedi#completions
    autocmd FileType java setlocal noexpandtab

	" Rainbow
	autocmd VimEnter * RainbowParenthesesToggle
	autocmd Syntax * RainbowParenthesesLoadRound		" ()
	autocmd Syntax * RainbowParenthesesLoadSquare	" []
	autocmd Syntax * RainbowParenthesesLoadBraces	" {}
	" au Syntax * RainbowParenthesesLoadChevrons	" <>

    "" highlight characters past column 150
    "autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    "autocmd FileType python match Excess /\%150.*/
augroup END

" http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap <Leader>8 :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction
