"
" |  \/  |_   _  \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | |  \ \ / / | || |\/| | |_) | |
" | |  | | |_| |   \ V /  | || |  | |  _ <| |___
" |_|  |_|\__, |    \_/  |___|_|  |_|_| \_\\____|
"         |___/

"My dir environments:
"~/ = Documents/ = iVim/
"Documents/vimrc
":!ln vimrc .vimrc
"Documents/bundle/vim-pathogen/autoload/pathogen.vim
"Install plugin: download zip from git, unzip in the 'Documents/bundlei' folder


" ===================
" === Update Vimrc===
" ===================
function! UpdateVimrc()
  exec 'e ~/.vimrc'
  exec 'set paste'
  exec '1,$d'
  exec 'r! curl https://raw.githubusercontent.com/BSDxxxx/config_files_backup_repo/master/.vimrc'
  exec '1d'
endfunction
command! UpdateVimrc :call UpdateVimrc()


" ====================
" === Editor Setup ===
" ====================

" ==============
" === System ===
" ==============
set nocompatible "这要放在前面,不然有些配置不会生效,如showcmd
set encoding=utf-8
let &t_ut='' "Prevent incorrect backgroung rendering
set clipboard^=unnamed,unnamedplus "与系统剪贴板关联
set swapfile
set updatetime=3000 "swapfile保存频率，默认4000ms
set updatecount=400 "swapfile保存触发，默认200字符，设为0将不保存
set linespace=4


" =======================
" === Dress Up My Vim ===
" =======================
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"let ayucolor='mirage'
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"let g:one_allow_italics = 1

highlight NonText ctermfg=gray guifg=grey10
"highlight SpecialKey ctermfg=blue guifg=grey70


" =============
" === netrw ===
" =============
"vim7.0后自带的文件浏览器，支持ftp,ssh,http远程浏览和编辑
"仿NERDTree配置
let g:netrw_banner = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 10
autocmd VimEnter * :Vexplore
autocmd VimEnter * wincmd l
aug netrw_close
	au!
	au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&filetype') == 'netrw'|q|endif
aug END


" =======================
" === Edirot behavior ===
" =======================
set relativenumber "相对行号
"noremap <F2> :set rnu!<CR>

" 自动注释、缩进，会导致i模式下ctrl键无效，而且会导致一些插件无法正常工作
"set paste
set pastetoggle=<F1>

" 英文拼写检查,相关指令见:help spell
nnoremap <F2> :set spell! spell?<CR>
inoremap <F2> <ESC>:set spell! spell?<CR>a
nnoremap <C-Tab> geea<C-x>s
inoremap <C-Tab> <Esc>geea<C-x>s

" 浏览时根据窗口大小自动换行
set wrap
"noremap <F5> :set wrap! wrap?<CR>
set textwidth=0 "写入模式自动换行,0代表不自动换行

set list "显示制表符和空格
"noremap <F6> :set list! list?<CR>
set listchars=tab:▶\ ,trail:□
"set expandtab "tab转空格
"set softtabstop=2 "配合expandtab，在空格和tab混用时，将多少个空格识别为tab
set tabstop=4 "调整tab的宽度等于几个空格
set shiftwidth=4 "键入tab时生成tab的个数(shiftwidth/tabstop)，不足1个用空格代替，同时也控制<<, >>, ==的缩进距离

syntax on
set scrolloff=5 "保证光标上/下方至少有5行可见
" Highlight cursorline
set cursorline
exec 'highlight CursorLine   cterm=NONE ctermbg=lightgray ctermfg=lightblue guibg=NONE guifg=NONE'
" Highlight cursorcolumn
"set cursorcolumn
"exec 'highlight CursorColumn cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE'

" Cursor color
"exec 'highlight Cursor guifg=white guibg=black'
"exec 'highlight iCursor guifg=white guibg=steelblue'

" 普通模式和写入模式显示不同样式的光标
" 第一种实现方式(无效请尝试另一种)
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
" 第二种实现方式
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" 自动缩进
"set cindent "采用C语言的标准缩进方式
"set autoindent "新增加的行和前一行具有相同的缩进形式
set smartindent "autoindent的升级版

set showcmd "实时显示操作

set wildmenu "command提示
set completeopt=noinsert,menuone,noselect,preview "command自动补全

set mouse=a "允许使用鼠标

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set ttyfast "should make scrolling faster
set lazyredraw "same as above

set visualbell

"set colorcolumn=80 "高亮第80列（一行代码最好不超过79个字）
set virtualedit=block

set indentexpr=
set backspace=indent,eol,start

" Status/command bar
set laststatus=2
set formatoptions-=tc

" Restore Cursor Position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | exe "normal! g'\"" | endif


" =======================
" === Leader Mappings ===
" =======================
let mapleader=' '
nnoremap <silent> <LEADER><CR> :nohlsearch<CR>

nnoremap <expr> <silent> <LEADER>rc ':e '.g:location_prefix.'/nvim/init.vim<CR>'
nnoremap <LEADER>o o<Esc>
nnoremap <LEADER>O O<Esc>
noremap <LEADER>j J

" Press space twice to jump to the next '<++>' and edit it
nnoremap <silent> <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Opening a terminal window
"noremap <silent> <LEADER>/ :set splitbelow<CR>:split<CR>:term<CR>

" copy file
nnoremap <silent> <LEADER>cf :let @+ = expand("%:t")<CR>
" copy relative path
"nnoremap <LEADER>cf :let @+ = expand("%")
" copy full path
nnoremap <silent> <LEADER>cp :let @+ = expand("%:p")<CR>
" copy directory name
nnoremap <silent> <LEADER>cd :let @+ = expand("%:p:h")<CR>


" ======================
" === Basic Mappings ===
" ======================
noremap j gj
noremap k gk

noremap J <C-d>
noremap K <C-u>
"nnoremap <expr> J line('.')==line('w$') ? '<c-f>j':'L'
"nnoremap <expr> K line('.')==line('w0') ? '<c-b>k':'H'
noremap H <Home>
nnoremap L <End>
xnoremap L <End>h
nnoremap dL d<End>
noremap 0 g0
noremap $ g$

noremap ; :
noremap q; q:
noremap : ;
noremap ` ~
noremap ~ `

noremap w W
noremap W B
noremap e E
noremap E ge

noremap U <C-r>
noremap <C-u> U
noremap Y y$
noremap vv V
noremap V v$h

"noremap <Backspace> "xX
" Do not use default register for these keys
noremap <expr> x v:register=='+' ? '"xx' : 'x'
noremap <expr> X v:register=='+' ? '"xX' : 'X'
noremap <expr> c v:register=='+' ? '"xc' : 'c'
noremap <expr> cc v:register=='+' ? '"xcc' : 'cc'
noremap <expr> C v:register=='+' ? '"xC' : 'C'

map = <C-a>
map - <C-x>
noremap __ ==

nnoremap <silent> bo :browse oldfiles<CR>

" save & quit & refresh
nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <ESC>:w<CR>
nnoremap <silent> <C-q> :q<CR>
nnoremap <expr> <silent> <C-r> ":source ".g:location_prefix."/nvim/init.vim<CR>"

" Select all
nnoremap sa ggVG

" Diff
function! DiffWith(path)
	exec 'vertical diffsplit '.a:path
endfunction
command! -nargs=+ -complete=file DiffWith :call DiffWith(<f-args>)
nnoremap \d :DiffWith 

" Force buffer delete
cnoreabbrev <expr> <silent> bd getcmdtype() == ":" && getcmdline() == 'bd' ? 'bd!' : 'bd'
"cnoremap bd bd!

" Pet messages to buffer
nnoremap \m :put=execute('')<Left><Left>


" ==================================
" === Inser Mode Cursor Movement ===
" ==================================
inoremap <M-h> <Left>
inoremap <M-l> <Right>
inoremap <M-k> <Up>
inoremap <M-j> <Down>
inoremap <M-i> <Home>
inoremap <M-a> <End>
inoremap <C-l> <Del>


" ====================================
" === Command Mode Cursor Movement ===
" ====================================
cnoremap <M-h> <Left>
cnoremap <M-l> <Right>
cnoremap <M-k> <Up>
cnoremap <M-j> <Down>
cnoremap <M-i> <Home>
cnoremap <M-a> <End>


" ====================
" === No Operation ===
" ====================
noremap b <nop>
noremap B <nop>
noremap s <nop>
noremap S <nop>
noremap ge <nop>
noremap <space> <nop>
inoremap <C-j> <nop>
inoremap <C-k> <nop>


" ========================
" === Search Behaviors ===
" ========================
set hlsearch
set incsearch "search instant preview
set ignorecase
set smartcase
set inccommand=split "即时预览命令效果，目前只支持:s替换

" Cmd hint and search index style, see :h shortmess
set shortmess+=c

" find and replace
nnoremap \s :%s//g<left><left>


" =============
" === Split ===
" =============
set splitright
set nosplitbelow
nnoremap <silent> sh :set nosplitright<CR>:vsplit<CR>
nnoremap <silent> sl :set splitright<CR>:vsplit<CR>
nnoremap <silent> sk :set nosplitbelow<CR>:split<CR>
nnoremap <silent> sj :set splitbelow<CR>:split<CR>

" Jump, <C-w><C-w>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Resize
nnoremap <silent> <Up> :res +5<CR>
nnoremap <silent> <Down> :res -5<CR>
nnoremap <silent> <Left> :vertical resize-5<CR>
nnoremap <silent> <Right> :vertical resize+5<CR>

" Vertical and horizen
noremap sv <C-w>t<C-w>H
noremap sr <C-w>t<C-w>K


" ===========
" === Tab ===
" ===========
nnoremap <silent> <C-t>t :tabe<CR>
nnoremap <silent> <C-t>h :-tabnext<CR>
nnoremap <silent> <C-t>l :+tabnext<CR>


" =====================
" === Fold Settings ===
" =====================
set foldenable              " 开始折叠
"set foldmethod=syntax       " 设置语法折叠
set foldmethod=indent       " 设置缩进折叠
"set foldcolumn=0            " 在屏幕左侧显示折叠状态条
set foldlevel=99
"setlocal foldlevel=1        " 设置折叠层数为
"set foldlevelstart=99       " 打开文件时默认不折叠代码
"set foldclose=all           " 设置为自动关闭折叠
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " 用空格键来开关折叠


" ==========================
" === Terminal Behaviors ===
" ==========================
" Open a new instance of st with the cwd
"nnoremap <silent> \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>

let g:neoterm_autoscroll = 1
"autocmd TermOpen term://* startinsert
augroup TermHandling
	autocmd!
	" mappings for exiting insert mode
	tnoremap <C-N> <C-\><C-N>
	tnoremap <C-O> <C-\><C-N><C-O>
	" Turn off line numbers, listchars, auto enter insert mode
	autocmd TermOpen * setlocal listchars= nonumber norelativenumber | startinsert
augroup END

let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'


" =========================
" === Custom Snippets =====
" =========================
" Insert date, time
nnoremap <silent> ,d a<C-R>=strftime('%Y-%m-%d')<CR><Esc>
inoremap <silent> ,d <C-R>=strftime('%Y-%m-%d')<CR>
nnoremap <silent> ,t a<C-R>=strftime('%H:%M:%S')<CR><Esc>
inoremap <silent> ,t <C-R>=strftime('%H:%M:%S')<CR>

"inoremap <silent> ‘ 「」《》<Esc>2hi
"inoremap <silent> ’ 「」《》<Esc>2hi
"inoremap <silent> “ 『』《》<Esc>2hi
"inoremap <silent> ” 『』《》<Esc>2hi
"inoremap <silent> （ （）《》<Esc>2hi
"inoremap <silent> 《 《》<Esc>i
"inoremap <silent> ，<LEADER> <Esc>/《》<CR>:nohlsearch<CR>"_c2l
"nnoremap <silent> ,<LEADER> /《》<CR>:nohlsearch<CR>"_c2l
inoremap <silent> ,p <C-r>*
inoremap <silent> ,,  <++>
inoremap <silent> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
nnoremap <silent> ,f /<++><CR>:nohlsearch<CR>"_c4l
"nnoremap <silent> ,<LEADER> a<SPACE><ESC>
autocmd Filetype markdown inoremap <buffer> <silent> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> <silent> ,- ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> <silent> ,b **** <++><Esc>F*hi
autocmd Filetype markdown xnoremap <buffer> <silent> ,b A**<Esc>gvI**<Esc>
autocmd Filetype markdown inoremap <buffer> <silent> ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown xnoremap <buffer> <silent> ,s A~~<Esc>gvI~~<Esc>
autocmd Filetype markdown inoremap <buffer> <silent> ,u <u></u><++><Esc>F/hi
autocmd Filetype markdown inoremap <buffer> <silent> ,i ** <++><Esc>F*i
autocmd Filetype markdown xnoremap <buffer> <silent> ,i A*<Esc>gvI*<Esc>
autocmd Filetype markdown inoremap <buffer> <silent> ,q `` <++><Esc>F`i
autocmd Filetype markdown xnoremap <buffer> <silent> ,q A`<Esc>gvI`<Esc>
autocmd Filetype markdown inoremap <buffer> <silent> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
"autocmd Filetype markdown inoremap <buffer> <silent> ,l - [ ] <Enter><++><ESC>kA
autocmd Filetype markdown inoremap <buffer> <silent> ,l - [ ] 
autocmd Filetype markdown inoremap <buffer> <silent> ,m ![](<++>)<Esc>F[a
autocmd Filetype markdown inoremap <buffer> <silent> ,a [](<++>) <++><Esc>F[a
"autocmd Filetype markdown inoremap <buffer> <silent> ,1 <Enter>===============<Enter><Enter><++><Esc>3kA
autocmd Filetype markdown inoremap <buffer> <silent> ,1 #<Space><Enter><Enter><++><Esc>2kA
autocmd Filetype markdown inoremap <buffer> <silent> ,2 ##<Space><Enter><Enter><++><Esc>2kA
autocmd Filetype markdown inoremap <buffer> <silent> ,3 ###<Space><Enter><Enter><++><Esc>2kA
autocmd Filetype markdown inoremap <buffer> <silent> ,4 ####<Space><Enter><Enter><++><Esc>2kA
"autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>


" ===========================
" === Other Userful Stuff ===
" ===========================
" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h
set autochdir "执行命令时默认在当前目录


" ======================
" === Plugin Install ===
" ======================
source ~/bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundle/{}', '~/bundle/{}')

"" 状态栏
"Plug 'vim-airline/vim-airline'

"" 主题
"Plug 'connorholyday/vim-snazzy'


"" File navigation
"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'Xuyuanp/nerdtree-git-plugin' "nerdtree识别git状态
"Plug 'ryanoasis/vim-devicons' "Add file type icons to Vim plugins such as: NERTTree, airline, startify...
""Plug 'Yggdroot/LeaderF', {'do': '.\install.bat' } "Error on windows
"Plug 'junegunn/fzf', { 'do': './install --bin' }
"Plug 'junegunn/fzf.vim'
"Plug 'yuki-ycino/fzf-preview.vim'

"" Taglist 显示函数列表
""Plug 'liuchengxu/vista.vim'

"" Quick Calculator
"Plug 'theniceboy/vim-calc'

"" Auto Complete
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

"" Find & Replace
"Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }

"" Undo Tree 在文件修改的历史版本中切换
"Plug 'mbbill/undotree'

"" Other visual enhancement
"Plug 'nathanaelkane/vim-indent-guides' "根据tab缩进对代码块分颜色显示
"Plug 'itchyny/vim-cursorword' "同名下划线

"" Git
"Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
""Plug 'rhysd/conflict-marker.vim'
""Plug 'tpope/vim-fugitive'
""Plug 'mhinz/vim-signify'
"Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }

"" Debugger
"Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}

"" HTML, CSS, JavaScript, PHP, JSON, etc.
""Plug 'elzr/vim-json'
""Plug 'hail2u/vim-css3-syntax'
""Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
""Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
""Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
""Plug 'mattn/emmet-vim'

"" Python
""Plug 'vim-scripts/indentpython.vim'

"" Markdown
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
""Plug 'suan/vim-instant-markdown' "another markdown preview
"Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' } "快速制表
""Plug 'masukomi/vim-markdown-folding' "Fold markdown documents by section. Notice:vimwiki already have md folding function.
"Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }
"Plug 'vimwiki/vimwiki' "wiki格式的目录管理
"Plug 'mattn/calendar-vim' "vimwiki官方指定日历插件,可显示日记
""Plug 'itchyny/calendar.vim' "日历，可本地使用，也可联动google日历和google task
"Plug 'dkarter/bullets.vim' "列表自增
"Plug 'vim-pandoc/vim-pandoc' "pandoc支持
"Plug 'vim-pandoc/vim-pandoc-syntax' "vim-pandoc插件的语法支持

"" Other useful utilities
"Plug 'terryma/vim-multiple-cursors' "<C-n>选中相同文本进入多行光标模式
"Plug 'junegunn/goyo.vim' " distraction free writing mode(fouce mode)
"Plug 'tpope/vim-surround' " 包裹字符或解包
"Plug 'Raimondi/delimitMate' "括号自动补全
"Plug 'godlygeek/tabular' " type :Tabularize /= to align the =
"Plug 'gcmt/wildfire.vim' " QuickSelect, in Visual mode, type i' to select all text in '', or type i) i] i} ip
"Plug 'scrooloose/nerdcommenter' " type <LEADER>cc to comment a line
"Plug 'ron89/thesaurus_query.vim' "查找近义词
"Plug 'mhinz/vim-startify' "启动vim时显示最近文件
"Plug 'luochen1990/rainbow' "Improved version of kein/rainbow_parentheses.vim
"Plug 'inkarkat/vim-EnhancedJumps' "增强<c-o> <c-i>的跳转功能，配合g可以在当前文件跳转，配合<LEADER>可以在不同文件中跳转，配合<LEADER><C-w>可以在不同窗口跳转，g;和g.允许跳转到最近的改变
"Plug 'junegunn/vim-peekaboo' "yank预览


"" Dependencies
"Plug 'inkarkat/vim-ingo-library'
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'kana/vim-textobj-user'
"Plug 'fadein/vim-FIGlet' "You need to install figlet to local first


" ===================== Start of Plugin Settings =====================


" =============
" === Theme ===
" =============
set background=dark
"set background=light

"说明：colo = colorscheme = colorscheme
"colo ayu
"let ayucolor='light'
"colo one
"colo deus
"colo dracula
"colo xcodedark
"colo snazzy
"colo snazzy
"let g:SnazzyTransparent = 1

"color gruvbox
"let g:gruvbox_contrast_dark        = 'soft' "soft|medium|hard
"let g:gruvbox_light                = 'medium'
"let g:gruvbox_hls_cursor           = 'orange'
"let g:gruvbox_invert_selection     = '0'
"let g:gruvbox_invert_indent_guides = '0'


" ===================== End of Plugin Settings =====================
