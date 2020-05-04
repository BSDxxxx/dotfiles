"
" |  \/  |_   _  \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | |  \ \ / / | || |\/| | |_) | |
" | |  | | |_| |   \ V /  | || |  | |  _ <| |___
" |_|  |_|\__, |    \_/  |___|_|  |_|_| \_\\____|
"         |___/
"This is hjkl version, win10 nvim-qt
".md is recognized as vimwiki.markdown.pandoc type
"查看vim键位说明:help key-notation  or  <C-v> in insert mode then press other key
"Todo: markdown insert link function; encrypt

let g:python_host_prog = 'D:\Python27\python.exe'
let g:python3_host_prog = 'D:\Python38\python.exe'

" ==================
" === Initialize ===
" ==================

" Initial path ($XDG_CONFIG_HOME)
if has('win32')
	let g:location_prefix='~/AppData/Local'
elseif has('mac')
	let g:location_prefix='~/.config'
elseif has('unix')
	let g:location_prefix='~/.config'
endif

" Auto load plug for first time uses vim
if empty(glob(location_prefix.'/nvim/autoload/plug.vim'))
	exec 'silent !curl -fLo '.g:location_prefix.'/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | exec 'source '.g:location_prefix.'/nvim/init.vim'
endif


" ====================
" === Editor Setup ===
" ====================

" ==============
" === System ===
" ==============
set nocompatible "这要放在前面,不然有些配置不会生效,如showcmd
let &t_ut='' "Prevent incorrect backgroung rendering
set clipboard^=unnamed,unnamedplus "与系统剪贴板关联

"exec 'silent !mkdir -p '.g:location_prefix.'/nvim/tmp/sessions'
" Set backup directory
exec 'silent !mkdir -p '.g:location_prefix.'/nvim/tmp/backup'
let &backupdir = g:location_prefix.'/nvim/tmp/backup,.' "The directory must exist, Vim will not auto create it
"set backup "writebackup option is default on, backup file will be delete after successful write in, but with backup option on, it will stay
set backupext=.vimbak
set backupskip=D:/Temp/*,*.asc,F:/vimwiki/* "Disable backup in specific directory

let &directory = g:location_prefix.'/nvim/tmp/backup,.' "The directory must exist, Vim will not auto create it
set swapfile
set updatetime=3000 "swapfile保存频率，默认4000ms
set updatecount=400 "swapfile保存触发，默认200字符，设为0将不保存

" 保存修改历史供每次编辑使用
exec 'silent !mkdir -p '.g:location_prefix.'/nvim/tmp/undo'
if has('persistent_undo')
	set undofile
	let &undodir = g:location_prefix.'/nvim/tmp/undo,.' "The directory must exist, Vim will not auto create it
endif

" 字体和字体大小
"set guifont=DejaVuSansMono\ Nerd\ Font\ Mono:h11
"set guifont=ProFontWindows\ Nerd\ Font\ Mono:h13
"set guifont=SauceCodePro\ NF:h12
set guifont=SauceCodePro\ Nerd\ Font:h12
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h10
set linespace=4

" Customizing colors
"let s:brown = '905532'
"let s:aqua =  '3AFFDB'
"let s:blue = '689FB6'
"let s:darkBlue = '44788E'
"let s:purple = '834F79'
"let s:lightPurple = '834F79'
"let s:red = 'AE403F'
"let s:beige = 'F5C06F'
"let s:yellow = 'F09F17'
"let s:orange = 'D4843E'
"let s:darkOrange = 'F16529'
"let s:pink = 'CB6F6F'
"let s:salmon = 'EE6E73'
"let s:green = '8FAA54'
"let s:lightGreen = '31B53E'
"let s:white = 'FFFFFF'
"let s:rspec_red = 'FE405F'
"let s:git_orange = 'F54D27'


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
" vim7.0后自带的文件浏览器，支持ftp,ssh,http远程浏览和编辑
let g:netrw_sort_by = 'name'
let g:netrw_sort_direction = 'normal'
let g:netrw_browse_split = 4
let g:netrw_liststyle = 4
let g:netrw_banner = 0
let g:netrw_altv = 1
let g:netrw_winsize = 22
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
"autocmd BufEnter vimwiki.marodown.pandoc set nowrap
"noremap <F5> :set wrap! wrap?<CR>
set textwidth=0 "写入模式自动换行,0代表不自动换行

set list "显示制表符和空格
"noremap <F6> :set list! list?<CR>
set listchars=tab:▶\ ,trail:□
autocmd FileType vimwiki.markdown.pandoc setlocal listchars=tab:\ \ ,trail:□

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
exec 'highlight Cursor guifg=white guibg=black'
exec 'highlight iCursor guifg=white guibg=steelblue'

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

set encoding=utf-8

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
"set foldenable              " 开始折叠
"set foldmethod=syntax       " 设置语法折叠
"set foldmethod=indent       " 设置缩进折叠
"set foldcolumn=0            " 在屏幕左侧显示折叠状态条
"set foldlevel=99
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

"n：剪贴板是否有url，光标在单词或空格上，单词则获取单词后wrap,否则直接wrap
"v：剪贴板是否有url，wrap选中区域
"i：剪贴板是否有url，wrap
"if under the cursor is a word or in visual mode, use the url in yank * to make current word or selection a markdown link, else just gave me a empty link area
function! CloseBracket(type)
	let l:wrap = "[\<C-r>\"](\<C-r>+)"
	if a:type ==? 'v'
		execute 'normal! gvs' . l:wrap
	elseif a:type ==? 'n'
		let l:char = matchstr(getline('.'), '\%' . col('.') . 'c.')
		if l:char =~ '^\s*$'
			execute "normal! i[](<++>) <++>\<Esc>F]"
			call feedkeys("i")
		else
			let l:reg = @"
			let @" = expand('<cword>')
			echom 'mode: ' . a:type
			if mode() ==? 'n'
				execute 'normal! ciw' . l:wrap
			endif
			let @" = l:reg
		endif
	endif
endfunction

function! CloseBracket2(type)
	let l:wrap = "[\<C-r>\"](\<C-r>+)"
	if a:type ==? 'v'
		execute 'normal! gvs' . l:wrap
	else
		let l:char = matchstr(getline('.'), '\%' . col('.') . 'c.')
		if l:char =~ '^\s*$'
			execute "normal! i[](<++>)\<esc>F]"
			call feedkeys("i")
		else
			let l:reg = @"
			let @" = expand('<cword>')
			echom 'mode: ' . a:type
			if mode() ==? 'n'
				execute 'normal! ciw' . l:wrap
			endif
			let @" = l:reg
		endif
	endif
endfunction

"autocmd Filetype markdown nnoremap <buffer> <silent> ,a :call CloseBracket('n')<CR>
"autocmd Filetype markdown xnoremap <buffer> <silent> ,a :call CloseBracket('v')<CR>

function! IsUrlInYank()
	let l:yank = @+
	"echo (match(l:yank, 'http') == '-1')
	"if match(l:yank, '\(https?|ftp|file)://') == '-1'
	if match(l:yank, '\(https\?\|ftp\|file\)://') == '-1'
	"if match(l:yank, 'https?') == '-1'
		echo '123'
	else
		echo '456'
	endif
endfunction

nnoremap <buffer> <silent> ,a :call CloseBracket('n')<CR>
xnoremap <buffer> <silent> ,a :call CloseBracket('v')<CR>


" ===========================
" === Other Userful Stuff ===
" ===========================
" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h
set autochdir "执行命令时默认在当前目录

" Compile function,根据不同文件类型执行不同的指令
noremap <LEADER>rr :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec 'w'
	if &filetype == 'c'
		exec '!g++ % -o %<'
		exec '!time ./%<'
	elseif &filetype == 'cpp'
		set splitbelow
		exec '!g++ -std=c++11 % -Wall -o %<'
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec '!javac %'
		exec '!time java %<'
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec '!'.g:mkdp_browser.' % &'
	elseif &filetype == 'vimwiki.markdown.pandoc'
		exec 'MarkdownPreview'
	elseif &filetype == 'tex'
		silent! exec 'VimtexStop'
		silent! exec 'VimtexCompile'
	elseif &filetype == 'dart'
		CocCommand flutter.run
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run %
	endif
endfunc


" ======================
" === Plugin Install ===
" ======================
call plug#begin('~/.vim/plugged')

" Status line
Plug 'vim-airline/vim-airline'

" Theme
"Plug 'connorholyday/vim-snazzy'
Plug 'morhetz/gruvbox'

" Input method
if has('win32')
	Plug 'Neur1n/neuims' "Auto switch input method
endif
"Plug 'ZSaberLv0/ZFVimIM' "Internal input method
"Plug 'BSDxxxx/ZFVimIM_pinyin_base' "repo that contain db files, see `cloud input (minimal recommend config)`
"Plug 'ZSaberLv0/ZFVimJob' "optional, for async db update
"Plug 'ZSaberLv0/ZFVimGitUtil' "optional, see `g:ZFVimIM_cloudAsync_autoCleanup`

" File navigation
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' } "在tab中同步nerdtree状态
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeTabsToggle' } "nerdtree识别git状态
Plug 'ZSaberLv0/nerdtree_menu_util', { 'on': 'NERDTreeTabsToggle' } "add useful item to nerdtree menu
Plug 'ryanoasis/vim-devicons' "Add file type icons to Vim plugins such as: NERTTree, airline, startify...
"Plug 'Yggdroot/LeaderF', {'do': '.\install.bat' } "Error on windows
if isdirectory('/usr/local/opt/fzf')
	Plug '/usr/local/opt/fzf'
else
	Plug 'junegunn/fzf', { 'do': './install --bin' }
endif
Plug 'junegunn/fzf.vim'
"Plug 'yuki-ycino/fzf-preview.vim' "Error on windows, using floaterm instead
"Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' } "create gitignore file(use coc-gitignore instead)
Plug 'voldikss/vim-floaterm'

" Taglist 显示函数列表
"Plug 'liuchengxu/vista.vim'

" Quick Calculator
"Plug 'theniceboy/vim-calc'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Find & Replace
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] } "Find and replace through multiple files

" Undo Tree 在文件修改的历史版本中切换
Plug 'mbbill/undotree'

" Other visual enhancement
Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' } "高亮缩进
"Plug 'Yggdroot/indentLine' "高亮缩进
Plug 'itchyny/vim-cursorword' "同名下划线

" Git
"Plug 'rhysd/conflict-marker.vim'
Plug 'kdheepak/lazygit.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim' "git log view
Plug 'airblade/vim-gitgutter' "show changes in file (note: coc-git has similar function)
"Plug 'mhinz/vim-signify' "show changes in file
"Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] } "auto completion for gitignore filetype

" Debugger
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}

" HTML, CSS, JavaScript, PHP, JSON, etc.
"Plug 'elzr/vim-json'
"Plug 'hail2u/vim-css3-syntax'
"Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less', 'vim'] } "color instant preview
"Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
"Plug 'mattn/emmet-vim'

" Python
"Plug 'vim-scripts/indentpython.vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['vimwiki', 'markdown', 'pandoc', 'diary', 'vim-plug'] }
"Plug 'suan/vim-instant-markdown' "Another markdown preview
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' } "快速制表
"Plug 'masukomi/vim-markdown-folding' "Fold markdown documents by section. Notice:vimwiki already have md folding function.
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }
Plug 'vimwiki/vimwiki', {'branch': 'dev'} "wiki 格式的目录管理
"Plug 'tbabej/taskwiki' "通过与 taskwarrior 交互来增强 vimwiki 的 todo list
"Plug 'mattn/calendar-vim' "vimwiki 官方指定日历插件
Plug 'itchyny/calendar.vim' "日历，可本地使用，也可联动google日历和google task
Plug 'dkarter/bullets.vim', { 'for': ['vimwiki', 'markdown', 'pandoc', 'diary', 'txt', 'gitcommit', 'scratch'] } "列表自增
Plug 'vim-pandoc/vim-pandoc' "pandoc支持，folding 功能意外的好用，对markdown 支持度很高
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['vimwiki', 'markdown', 'pandoc', 'diary'] } "pandoc markdown syntax highlight

" Other useful utilities
"Plug 'blindFS/vim-taskwarrior'
"Plug 'linuxcaffe/tw-airline-plugin'
"Plug 'liuchengxu/graphviz.vim'
"Plug 'wannesm/wmgraphviz.vim'
"Plug 'weirongxu/plantuml-previewer.vim' "preview plantuml with browser
Plug 'scrooloose/vim-slumlord', { 'for': ['uml', 'plantuml'] } "live preview of plantuml
Plug 'aklt/plantuml-syntax', { 'for': ['uml', 'plantuml'] } "
Plug 'tpope/vim-speeddating' "make <C-a> & <C-x> works for date format
Plug 'tpope/vim-repeat' "enhance . operation
Plug 'easymotion/vim-easymotion' "光标快速定位、跳转
Plug 'ZSaberLv0/vim-easymotion-chs' "allow easymotion recognize Chinese with English words
Plug 'skywind3000/vim-quickui' "popup menu
Plug 'terryma/vim-multiple-cursors' "<C-n>选中相同文本进入多行光标模式
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " distraction free writing mode(fouce mode)
Plug 'tpope/vim-surround' " 包裹字符或解包
"Plug 'Raimondi/delimitMate' "括号自动补全（using coc-pairs instead）
Plug 'godlygeek/tabular' " type :Tabularize /= to align the =
Plug 'gcmt/wildfire.vim' " QuickSelect, in Visual mode, type i' to select all text in '', or type i) i] i} ip
Plug 'scrooloose/nerdcommenter' " type <LEADER>cc to comment a line
Plug 'ron89/thesaurus_query.vim' "查找近义词
Plug 'mhinz/vim-startify' "启动vim时显示最近文件
Plug 'luochen1990/rainbow' "Improved version of kein/rainbow_parentheses.vim
Plug 'inkarkat/vim-EnhancedJumps' "增强<c-o> <c-i>的跳转功能，配合g可以在当前文件跳转，配合<LEADER>可以在不同文件中跳转，配合<LEADER><C-w>可以在不同窗口跳转，g;和g.允许跳转到最近的改变
Plug 'junegunn/vim-peekaboo' "yank preview
Plug 'kshenoy/vim-signature' "take over default mark: mark preview, multiple marks (<=2), custom mark signs, highlight sign
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } "Enable neovim in browser

" Dependencies
Plug 'inkarkat/vim-ingo-library'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-textobj-user'
Plug 'fadein/vim-FIGlet' "You need to install figlet to local first

call plug#end()


" ===================== Start of Plugin Settings =====================

" ===============
" === Airline ===
" ===============
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
"let g:airline#extensions#keymap#enabled = 1


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

color gruvbox
let g:gruvbox_contrast_dark        = 'soft' "soft|medium|hard
let g:gruvbox_light                = 'medium'
let g:gruvbox_hls_cursor           = 'orange'
let g:gruvbox_invert_selection     = '0'
let g:gruvbox_invert_indent_guides = '0'


" ==============
" === Neuims ===
" ==============
"if has('win32')
	""Auto switch to ENG (win10) when start a buffer
	"autocmd VimEnter * call neuims#Toggle()
	"autocmd VimEnter * call neuims#Switch(1)
	"autocmd VimEnter * call neuims#Switch(0)
"endif


" ===============
" === ZFVimIM ===
" ===============
"execute 'source '.g:location_prefix.'/nvim/ZFVimIM.vim'


" ================
" === NERDTree ===
" ================
"let NERDTreeMapOpenExpl          = ''
let NERDTreeMapOpenSplit          = 'sh'
let g:NERDTreeMapPreviewSplit     = 'Sh'
let NERDTreeMapOpenVSplit         = 'sl'
let g:NERDTreeMapPreviewVSplit    = 'Sl'
let NERDTreeMapCloseDir           = '-'
let NERDTreeMapCloseChildren      = '_'
let NERDTreeMapChangeRoot         = 'i'
let NERDTreeMapJumpRoot           = 'gg'
let g:NERDTreeDirArrowExpandable  = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeWinSize             = 23
let NERDTreeShowHidden            = 1
let NERDTreeShowBookmarks         = 1
let NERDTreeBookmarksSort         = 2
let NERDTreeCaseSensitiveSort     = 1
let NERDTreeNaturalSort           = 1
let NERDTreeIgnore                = ['\.pyc$', '\.pyd$'] "隐藏指定后缀文件
let NERDTreeSortOrder             = ['\/$', '*', '\.swp$', '\.bak$', '\.vimbak$', '\~$'] "顺序置顶指定后缀文件
"无文件打开自动退出vim
autocmd BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
"NERDTree statusline
"let NERDTreeStatusline           = '%{ getcwd() }'
let NERDTreeStatusline            = "m:menu u:up i:in"
"let NERDTreeStatusline           = "%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"
"let NERDTreeStatusline           = "%{exists('b:NERDTree')?b:NERDTree.root.path.str():''}"

"NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" 禁用下划线以减少延迟
"let g:NERDTreeHighlightCursorline = 0


" =====================
" === NERDTree-tabs ===
" =====================
nnoremap <silent> <C-e> :NERDTreeTabsToggle<CR>


" ====================
" === NERDTree-git ===
" ====================
let g:NERDTreeIndicatorMapCustom = {
	\ 'Modified'  : '✹',
	\ 'Staged'    : '✚',
	\ 'Untracked' : '✭',
	\ 'Renamed'   : '➜',
	\ 'Unmerged'  : '═',
	\ 'Deleted'   : '✖',
	\ 'Dirty'     : '✗',
	\ 'Clean'     : '✔︎',
	\ 'Unknown'   : '?'
	\ }


" ==========================
" === nerdtree_menu_util ===
" ==========================
"xxx: yank, cut, paste, copypath, run, size, quit
"let g:nmu_xxx_enable = 1
"let g:nmu_xxx_text = 1
"let g:nmu_xxx_key = 1
"let g:nmu_copypath_registers = ['*', '"', '0']


" ===
" === LeaderF
" ===
"let g:Lf_PythonVersion = 2
"let g:Lf_UseCache = 0
"let g:Lf_UseVersionControlTool = 0
"let g:Lf_IgnoreCurrentBufferName = 1
"let g:Lf_HideHelp = 1 " don't show the help in normal mode

"let g:Lf_ShortcutF = '<leader>ff'
"search visually selected text literally
"xnoremap gf :<C-U><C-R>=printf('Leaderf! rg -F -e %s ', leaderf#Rg#visual())<CR>
"noremap go :<C-U>Leaderf! rg --recall<CR>

""" should use `Leaderf gtags --update` first
"let g:Lf_GtagsAutoGenerate = 0
"let g:Lf_Gtagslabel = 'native-pygments'
"noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand('<cword>'))<CR><CR>
"noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand('<cword>'))<CR><CR>
"noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", '')<CR><CR>
"noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", '')<CR><CR>
"noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", '')<CR><CR>

"" popup mode
"let g:Lf_WindowPosition = 'popup'
"let g:Lf_PreviewInPopup = 1
"let g:Lf_StlSeparator = { 'left': '\ue0b0', 'right': '\ue0b2', 'font': 'DejaVu Sans Mono for Powerline' }
"let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

"" 弹出面板颜色
"let g:Lf_PopupPalette = {
	"\  'light': {
	"\      'Lf_hl_match': {
	"\                'gui': 'NONE',
	"\                'font': 'NONE',
	"\                'guifg': 'NONE',
	"\                'guibg': '#303136',
	"\                'cterm': 'NONE',
	"\                'ctermfg': 'NONE',
	"\                'ctermbg': '236'
	"\              },
	"\      'Lf_hl_cursorline': {
	"\                'gui': 'NONE',
	"\                'font': 'NONE',
	"\                'guifg': 'NONE',
	"\                'guibg': '#303136',
	"\                'cterm': 'NONE',
	"\                'ctermfg': 'NONE',
	"\                'ctermbg': '236'
	"\              },
	"\      },
	"\  'dark': {
	"\      }
	"\  }


" ===========
" === FZF ===
" ===========
noremap <silent> <C-f>f :FZF<CR>
noremap <silent> <C-f>a :Ag<CR>
noremap <silent> <C-f>m :MRU<CR>
noremap <silent> <C-f>t :BTags<CR>
noremap <silent> <C-f>l :LinesWithPreview<CR>
noremap <silent> <C-f>b :Buffers<CR>
noremap <silent> <C-f>c :History:<CR>

"让输入上方，搜索列表在下方
let $FZF_DEFAULT_OPTS = '--layout=reverse'
"打开 fzf 的方式选择 floating window
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
"指定如何打开浮动窗口的函数
function! OpenFloatingWin()
	let height = &lines - 3
	let width = float2nr(&columns - (&columns * 2 / 10))
	let col = float2nr((&columns - width) / 2)

	" 设置浮动窗口打开的位置，大小等。
	" 这里的大小配置可能不是那么的 flexible 有继续改进的空间
	let opts = {
		\ 'relative': 'editor',
		\ 'row': height * 0.3,
		\ 'col': col + 30,
		\ 'width': width * 2 / 3,
		\ 'height': height / 2
		\ }

	let buf = nvim_create_buf(v:false, v:true)
	let win = nvim_open_win(buf, v:true, opts)

	" 设置浮动窗口高亮
	call setwinvar(win, '&winhl', 'Normal:Pmenu')

	setlocal
		\ buftype=nofile
		\ nobuflisted
		\ bufhidden=hide
		\ nonumber
		\ norelativenumber
		\ signcolumn=no
endfunction

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
	\| autocmd BufLeave <buffer> set laststatus=2 ruler

command! -bang -nargs=* Buffers
	\ call fzf#vim#buffers(
	\   '',
	\   <bang>0 ? fzf#vim#with_preview('up:60%')
	\           : fzf#vim#with_preview('right:0%', '?'),
	\   <bang>0)


command! -bang -nargs=* LinesWithPreview
	\ call fzf#vim#grep(
	\   'rg --with-filename --column --line-number --no-heading --color=always --smart-case . '.fnameescape(expand('%')), 1,
	\   fzf#vim#with_preview({}, 'up:50%', '?'),
	\   1)

command! -bang -nargs=* Ag
	\ call fzf#vim#ag(
	\   '',
	\   <bang>0 ? fzf#vim#with_preview('up:60%')
	\           : fzf#vim#with_preview('right:50%', '?'),
	\   <bang>0)


command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())

command! -bang BTags
	\ call fzf#vim#buffer_tags('', {
	\     'down': '40%',
	\     'options': '--with-nth 1 
	\                 --reverse 
	\                 --prompt '> ' 
	\                 --preview-window='70%' 
	\                 --preview "
	\                     tail -n +\$(echo {3} | tr -d \";\\\"\") {2} |
	\                     head -n 16"'
	\ })


" =====================
" === fzf-gitignore ===
" =====================
"noremap <LEADER>gi :FzfGitignore<CR>


" =======================
" === fzf-preview.vim ===
" =======================
let g:fzf_preview_default_key_bindings = 'ctrl-e:down,ctrl-u:up'
let g:fzf_preview_layout               = 'belowright split new'
let g:fzf_preview_rate                 = 0.4
let g:fzf_full_preview_toggle_key      = '<C-f>'
let g:fzf_preview_command              = 'ccat --color                = always {-1}'
let g:fzf_binary_preview_command       = 'echo "It is a binary file"'


" ====================
" === vim-floaterm ===
" ====================
autocmd User Startified setlocal buflisted "bug fix
let g:floaterm_position      = "center"
let g:floaterm_keymap_new    = '\t'
let g:floaterm_keymap_prev   = '\p'
let g:floaterm_keymap_next   = '\n'
"let g:floaterm_keymap_toggle= '<F10>'
let g:floaterm_autoinsert    = 0
"hi FloatermNF guibg=gray
hi FloatermBorderNF guifg=salmon


" =================
" === Vista.vim ===
" =================
"noremap <silent> T :Vista!!<CR>
"let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
"let g:vista_default_executive = 'ctags'
"let g:vista_fzf_preview = ['right:50%']
"let g:vista#renderer#enable_icon = 1
"let g:vista#renderer#icons = {
"\   'function': '\uf794',
"\   'variable': '\uf71b',
"\  }
"function! NearestMethodOrFunction() abort
	"return get(b:, 'vista_nearest_method_or_function', '')
"endfunction
"set statusline+=%{NearestMethodOrFunction()}
"autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


" ===========
" === COC ===
" ===========
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-gitignore', 'coc-vimlsp', 'coc-tailwindcss', 'coc-stylelint', 'coc-tslint', 'coc-lists', 'coc-explorer', 'coc-pyright', 'coc-sourcekit', 'coc-translator', 'coc-flutter', 'coc-markmap', 'coc-pairs']

" Add (Neo)Vim's native statusline support. NOTE: Please see `:h coc-status` for integrations with external plugins that provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" <Tab> and <S-Tab> trigger completion and navigate to the next complete item
inoremap <expr> <silent> <Tab>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <TAB> for selections ranges. NOTE: Requires 'textDocument/selectionRange' support from the language server. coc-tsserver, coc-python are the examples of servers that support it.
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)

" Open up coc-commands
nnoremap <C-c> :CocCommand<CR>
" Text Objects
"xmap kf <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap kf <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)

" coc-yank
nnoremap <silent> <C-y> :<C-u>CocList -A --normal yank<cr>
inoremap <silent> <C-y> <ESC>:<C-u>CocList -A --normal yank<cr>

" 跳转到函数定义
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)

" 找到函数的所有引用
"nmap <silent> gr <Plug>(coc-references)
"nmap <leader>rn <Plug>(coc-rename)

" coc-explorer
"nnoremap tt :CocCommand explorer --toggle --position left<CR>
"nnoremap <silent><leader>d :<C-u>exec("CocCommand explorer --toggle --position floating --floating-width " . float2nr(&columns * 0.6) . " --floating-height " . float2nr(&lines * 0.6))<CR>

" coc-translator
nmap <LEADER>ts <Plug>(coc-translator-p)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" coc-markmap
"nmap <Leader>mm <Plug>(coc-markmap-create)
" Create markmap from the selected lines
"vmap <Leader>m <Plug>(coc-markmap-create-v)
command! -range=% Markmap CocCommand markmap.create <line1> <line2>

" coc-pairs
autocmd FileType vim let b:coc_pairs_disabled = ['"']
"formatOnType: insert empty line when <CR>
inoremap <silent><expr> <cr> "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" =================
" === Ultisnips ===
" =================
let g:tex_flavor = 'latex'
"inoremap <C-n> <nop>
let g:UltiSnipsExpandTrigger       = '<C-e>'
let g:UltiSnipsJumpForwardTrigger  = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsListSnippets        = ''
let g:UltiSnipsSnippetDirectories  = [g:location_prefix.'/nvim/Ultisnips']
let g:UltiSnipsEditSplit           = 'vertical'
"silent! autocmd BufEnter,BufRead,BufNewFile * silent! unmap <c-r>


" ========================
" === Markdown-Preview ===
" ========================
" vim 的 updatetime 设置越小（如 100），同步滚动越灵活
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'chrome'
let g:mkdp_echo_preview_url = 1
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
	\ 'mkit': {},
	\ 'katex': {},
	\ 'uml': {},
	\ 'maid': {},
	\ 'disable_sync_scroll': 0,
	\ 'sync_scroll_type': 'middle',
	\ 'hide_yaml_meta': 1,
	\ 'sequence_diagrams': {},
	\ 'flowchart_diagrams': {}
	\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = '80'
let g:mkdp_page_title = '「${name}」'
" mappings
"nmap <LEADER>p <Plug>MarkdownPreview
"nmap <M-s> <Plug>MarkdownPreviewStop
"nmap <C-p> <Plug>MarkdownPreviewToggle


" ======================
" === vim-table-mode ===
" ======================
nnoremap <silent> <LEADER>tm :TableModeToggle<CR>
let g:table_mode_corner='|' "边框
let g:table_mode_corner_corner='|' "角落
let g:table_mode_header_fillchar='-' "表头分割线
let g:table_mode_motion_up_map = '<M-k>'
let g:table_mode_motion_down_map = '<M-j>'
let g:table_mode_motion_left_map = '<M-h>'
let g:table_mode_motion_right_map = '<M-l>'
"<LEADER>tdc--删除列
"<LEADER>tt--csv to table,前面加数字可以指定行数
let g:table_mode_delimiter = ','
"<Leader>ts--Sort a column under the cursor. This invokes TableSort


" ========================
" === vim-markdown-toc ===
" ========================
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'


" ===============
" === Vimwiki ===
" ===============
"中文文档: https://github.com/vimwiki/vimwiki/blob/master/README-cn.md
autocmd filetype vimwiki.markdown.pandoc nnoremap <buffer> <silent> <LEADER>x :VimwikiToggleListItem<CR>
autocmd filetype vimwiki.markdown.pandoc xnoremap <buffer> <silent> <LEADER>x :VimwikiToggleListItem<CR>
autocmd filetype vimwiki.markdown.pandoc inoremap <buffer> <silent> <LEADER>x <Esc>:VimwikiToggleListItem<CR>a
" wait for implement
"autocmd filetype vimwiki.markdown.pandoc nnoremap <buffer> <silent> + <Plug>VimwikiAddHeaderLevel
"autocmd filetype vimwiki.markdown.pandoc xnoremap <buffer> <silent> + <Plug>VimwikiAddHeaderLevel
"autocmd filetype vimwiki.markdown.pandoc nnoremap <buffer> <silent> _ <Plug>VimwikiRemoveHeaderLevel
"autocmd filetype vimwiki.markdown.pandoc xnoremap <buffer> <silent> _ <Plug>VimwikiRemoveHeaderLevel
autocmd filetype vimwiki.markdown.pandoc nnoremap <buffer> <silent> + I#<Esc>
autocmd filetype vimwiki.markdown.pandoc xnoremap <buffer> <silent> + I#<Esc>
autocmd filetype vimwiki.markdown.pandoc nnoremap <buffer> <silent> _ I<Del><Esc>
autocmd filetype vimwiki.markdown.pandoc xnoremap <buffer> <silent> _ I<Del><Esc>
nmap <silent> <Leader>wi <Plug>VimwikiIndex
nmap <silent> <Leader>w<Leader>i <Plug>VimwikiDiaryIndex
nmap <silent> <Leader>w<Leader>g <Plug>VimwikiDiaryGenerateLinks
"nmap <Leader>w<Leader>w <Plug>VimwikiMakeDiaryNote
let g:vimwiki_key_mappings =
\ {
\   'all_maps': 1,
\   'global': 1,
\   'headers': 0,
\   'text_objs': 1,
\   'table_format': 1,
\   'table_mappings': 0,
\   'lists': 0,
\   'links': 1,
\   'html': 1,
\   'mouse': 0,
\ }

"指定vimwiki的根目录，使用markdown语法而不是维基语法，把vimwiki的后缀改成了markdown
let g:vimwiki_list = [{
	\ 'exclude_files': [],
	\ 'path': 'F:\vimwiki\',
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'auto_tags': 1,
	\ 'auto_generate_tags': 1,
	\ 'auto_diary_index': 1,
	\ 'auto_generate_links': 1,
	\ 'list_margin': 0,
	\},
	\{
	\ 'path': g:location_prefix.'/nvim/wiki',
	\ 'automatic_nested_syntaxes': 1,
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'link_space_char': '_',
	\ 'path_html': g:location_prefix.'/nvim/wiki_html',
	\ 'template_default':'markdown',
	\ 'template_path': g:location_prefix.'/nvim/vimwiki/template/',
	\ 'custom_wiki2html': g:location_prefix.'/nvim/vimwiki/wiki2html.sh',
	\ 'template_ext': '.html',
	\}]

let g:vimwiki_CJK_length                               = 1 "是否在计算字串长度时用特别考虑中文字符
let g:vimwiki_hl_headers                               = 1
let g:vimwiki_hl_cb_checked                            = 2
au BufEnter *.wiki :syntax sync fromstart
let g:vimwiki_ext2syntax                               = {'.md': 'markdown', '.markdown': 'markdown'}
let g:vimwiki_markdown_link_ext                        = 1 "append file ext when creating a link
let g:vimwiki_filetypes                                = ['markdown', 'pandoc'] "set filetype vimwiki to vimwiki.markdown.pandoc
"autocmd Filetype vimwiki.markdown.pandoc set filetype = markdown.vimwiki.pandoc
let g:vimwiki_global_ext                               = 0 "change filetype globally or just in work path
let g:diary_caption_level                              = 0
let g:vimwiki_use_calendar                             = 1
let g:vimwiki_folding                                 = 'custom' "allow other plugin(pandoc) to handle folding syntax
function! VimwikiFoldLevelCustom(lnum)
	let pounds = strlen(matchstr(getline(a:lnum), '^#\+'))
	if (pounds)
		return '>' . pounds  " start a fold level
	endif
	return '=' " return previous fold level
endfunction

augroup VimrcAuGroup
autocmd!
autocmd FileType vimwiki setlocal foldmethod=expr |
	\ setlocal foldenable | set foldexpr=VimwikiFoldLevelCustom(v:lnum)
augroup END

let g:taskwiki_sort_orders     = {'C': 'pri-'}
let g:taskwiki_syntax          = 'markdown'
let g:taskwiki_markup_syntax   = 'markdown'
let g:taskwiki_markdown_syntax = 'markdown'


" ====================
" === calendar-vim ===
" ====================
"nnoremap <LEADER>ct :CalendarT<CR>
"nnoremap <LEADER>ch :CalendarH<CR>
"nnoremap <LEADER>cv :CalendarVR<CR>

" ====================
" === calendar.vim ===
" ====================
language message en_US.UTF-8
language time en_US.UTF-8

let g:calendar_frame            = 'default'
let g:calendar_task             = 1
let g:calendar_event_start_time = 1

" google clendar
"let g:calendar_google_calendar = 1
"let g:calendar_google_task = 1
"let g:calendar_google_api_key = '...'
"let g:calendar_google_client_id = '....apps.googleusercontent.com'
"let g:calendar_google_client_secret = '...'

"与vimwiki交互,创建diary
autocmd FileType calendar nnoremap <buffer> <CR> :<C-u>call vimwiki#diary#calendar_action(b:calendar.day().get_day(), b:calendar.day().get_month(), b:calendar.day().get_year(), b:calendar.day().week(), 'V')<CR>

" mappings
nnoremap <silent> <Leader>ct :Calendar<CR>
":Calendar -view=year
nnoremap <silent> <Leader>cv :Calendar -view=year -split=vertical -position=right -width=27<CR>
nnoremap <silent> <Leader>ch :Calendar -view=year -split=horizontal -position=below -height=12<CR>
":Calendar -first_day=monday
noremap <silent> <Leader>gt :Calendar -view=clock -position=here<CR>
augroup calendar-mappings
	autocmd!
	autocmd FileType calendar nmap <buffer> J <Plug>(calendar_down_large)
	autocmd FileType calendar nmap <buffer> K <Plug>(calendar_up_large)
	autocmd FileType calendar nmap <buffer> i <Plug>(calendar_start_insert)
	autocmd FileType calendar nmap <buffer> I <Plug>(calendar_start_insert_head)
	autocmd FileType calendar nmap <buffer> t <Plug>(calendar_task)
	autocmd FileType calendar nmap <buffer> T <Plug>(calendar_today)
	autocmd FileType calendar nmap <buffer> e <Plug>(calendar_event)
augroup END


" ============================
" === vim-markdown-folding ===
" ============================
" 改用pandoc的折叠功能了
"let g:markdown_fold_override_foldtext=1 "自动折叠
"autocmd FileType vimwiki.markdown.pandoc set foldexpr=StackedMarkdownFolds() "使用堆叠折叠
""autocmd FileType vimwiki.markdown.pandoc set foldexpr=NestedMarkdownFolds() "使用深层嵌套折叠
"noremap <silent> <LEADER>fo :foldopen<CR>
"noremap <silent> <LEADER>fc :foldclose<CR>


" ===================
" === bullets.vim ===
" ===================
let g:bullets_set_mappings                = 1
let g:bullets_enabled_file_types          = ['vimwiki', 'markdown', 'pandoc', 'diary', 'txt', 'gitcommit', 'scratch']
let g:bullets_enable_in_empty_buffers     = 1
let g:bullets_delete_last_bullet_if_empty = 0


" ==============
" === Pandoc ===
" ==============
nnoremap <silent> <C-F8> :call ToDocx()<CR>
"nnoremap <silent> <C-F9> :call ToPdf()<CR>
function! ToDocx()
	exec 'w'
	exec '!pandoc --from=markdown --to=docx  % --output %<.docx'
endfunction
"function! ToPdf()
	"exec 'w'
	"exec '!pandoc --latex-engine=xelatex --template= 你自己的模板  % --output %<.pdf'
"endfunction

let g:pandoc#toc#position                               = 'left'
let g:pandoc#formatting#textwidth                       = 0 "default 79
let g:pandoc#formatting#mode                            = 's'
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#folding#level                              = 9
let g:pandoc#folding#fdc                                = 0
let g:pandoc#folding#mode                               = 'relative'
let g:pandoc#folding#fold_fenced_codeblocks             = 1
let g:pandoc#filetypes#handled                          = ['markdown','pandoc']
let g:pandoc#filetypes#pandoc_markdown                  = 0
let g:pandoc#modules#disabled                           = ['spell']
let g:pandoc#modules#enable                             = ['folding', 'command']
let g:pandoc#completion#bib#mode                        = 'citeproc'
"let g:pandoc#syntax#colorcolumn                        = 1 "causes display bug
let g:pandoc#toc#close_after_navigating                 = 0


" =====================
" === pandoc-syntax ===
" =====================
let g:pandoc#syntax#conceal#urls               = 1
let g:pandoc#syntax#conceal#use                = 1
"let g:pandoc#syntax#conceal#blacklist          = ['strikeout']
let g:pandoc#syntax#conceal#cchar_overrides    = {'codelang': '◤'}
let g:pandoc#syntax#style#use_definition_lists = 1 "Disabling this can improve performance


" =========================
" === vim-indent-guides ===
" =========================
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_color_change_percent = 1
"silent! unmap <LEADER>ig
"autocmd WinEnter * silent! unmap <LEADER>ig


" ===================
" === lazygit.vim ===
" ===================
nnoremap <silent> <leader>lg :LazyGit<CR>
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window


" =================
" === gitgutter ===
" =================
"let g:gitgutter_map_keys = 0
"set foldtext=gitgutter#fold#foldtext()
if has('win32')
	let g:gitgutter_git_executable = 'D:\Git\bin\git.exe'
endif


" ==================
" === Vimspector ===
" ==================
"默认占用了<F3>~<F12>
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r '.g:location_prefix.'/nvim/sample_vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 '.g:location_prefix.'/nvim/sample_vimspector_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad


" ============
" === Goyo ===
" ============
nnoremap <LEADER>gy :Goyo<CR>


" ===================
" === vim-surrond ===
" ===================
"let g:surround_no_mappings=1 "禁用defalut mapping
"ds for delet surroundings
"cs for change surroundings
"cst for change surroundings to(I think it's a quick mode compare to cs)
"yss for add surroundings to line
"ysiw for add surroundings to word(y for you)
"S in visual line mode for add surroundings to selected part


" ================
" === Undotree ===
" ================
nnoremap sm :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen       = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators    = 1
let g:undotree_WindowLayout       = 2
let g:undotree_DiffpanelHeight    = 8
let g:undotree_SplitWidth         = 24
function g:Undotree_CustomMap()
	nmap <buffer> u <plug>UndotreeNextState
	nmap <buffer> e <plug>UndotreePreviousState
	nmap <buffer> U 5<plug>UndotreeNextState
	nmap <buffer> E 5<plug>UndotreePreviousState
endfunc


" ================
" === graphviz ===
" ================
"let g:graphviz_viewer = 'open'
"let g:graphviz_output_format = 'pdf'
"let g:graphviz_shell_option = ''


" ===================
" === speeddating ===
" ===================
"map d= d<C-a>
"map d- d<C-x>


" ==================
" === vim-repeat ===
" ==================
" Unmap <C-r> for repeat
map <nop> <Plug>(RepeatRedo)


" ==================
" === easymotion ===
" ==================
let g:EasyMotion_smartcase = 1
map \ <Plug>(easymotion-prefix)
" 1 character locate
nmap \k <Plug>(easymotion-s)
xmap \k <Plug>(easymotion-s)
omap \k <Plug>(easymotion-s)
" 2 characters locate
nmap \j <Plug>(easymotion-s2)
xmap \j <Plug>(easymotion-s2)
omap \j <Plug>(easymotion-s2)


" ===============
" === quickui ===
" ===============
nnoremap <silent> \\ :call quickui#menu#open()<CR>
"nnoremap <silent>K :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>
if has('gui_running') || has('nvim')
	noremap <C-F10> :call MenuHelp_TaskList()<CR>
endif
execute 'source '.g:location_prefix.'/nvim/quickui.vim'
let g:quickui_color_scheme = 'gruvbox'
let g:quickui_border_style = 2


" ===========================
" === vim-multiple-cursor ===
" ===========================
"let g:multi_cursor_use_default_mapping= 0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<M-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<C-a>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-s>'
let g:multi_cursor_quit_key            = '<Esc>'


" ===================
" === delimitMate ===
" ===================
"let delimitMate_matchpairs = '(:),[:],{:},<:>'
"au FileType vim,html let b:delimitMate_matchpairs = '(:),[:],{:},<:>'


" =======================
" === thesaurus_query ===
" =======================
let g:tq_languages=['en', 'cn']
let g:tq_map_keys=0
noremap <LEADER>ss :ThesaurusQueryLookupCurrentWord<CR>
noremap <LEADER>sr :ThesaurusQueryReplaceCurrentWord<CR>


" ===============
" === far.vim ===
" ===============
noremap \f :F  **/*<left><left><left><left><left>
let g:far#enable_undo = 1
"let g:far#mapping = {
	"\ 'replace_undo' : ['l'],
	"\ }


" ================
" === vim-calc ===
" ================
"noremap <LEADER>a :call Calc()<CR>


" ================
" === Startify ===
" ================
"scriptencoding utf-8
let g:startify_bookmarks = [ {'g': 'f:/ProgramFiles/GitHub/config_files_backup_repo'} ]
let g:startify_lists = [
	\ { 'type': 'files',     'header': ['   MRU']            },
	\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
	\ { 'type': 'sessions',  'header': ['   Sessions']       },
	\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
	\ { 'type': 'commands',  'header': ['   Commands']       },
	\ ]
let s:greetings = {
	\ 'hello': ['██╗   ██╗ ████████╗ ██╗       ██╗        ██████╗ ',
	\           '██║   ██║ ██╔═════╝ ██║       ██║       ██╔═══██╗',
	\           '████████║ ██████╗   ██║       ██║       ██║   ██║',
	\           '██╔═══██║ ██╔═══╝   ██║       ██║       ██║   ██║',
	\           '██║   ██║ ████████╗ ████████╗ ████████╗ ╚██████╔╝',
	\           '╚═╝   ╚═╝ ╚═══════╝ ╚═══════╝ ╚═══════╝  ╚═════╝ '
	\          ],
	\ 'neovim': ['███╗  ██╗ ████████╗  ██████╗  ██╗     ██╗ ██╗ ███╗   ███╗',
	\            '████╗ ██║ ██╔═════╝ ██╔═══██╗  ██╗   ██╔╝ ██║ ████╗ ████║',
	\            '██╔██╗██║ ██████╗   ██║   ██║   ██╗ ██╔╝  ██║ ██╔████╔██║',
	\            '██║╚████║ ██╔═══╝   ██║   ██║    ████╔╝   ██║ ██║╚██╔╝██║',
	\            '██║ ╚███║ ████████╗ ╚██████╔╝     ██╔╝    ██║ ██║ ╚═╝ ██║',
	\            '╚═╝  ╚══╝ ╚═══════╝  ╚═════╝      ╚═╝     ╚═╝ ╚═╝     ╚═╝'
	\        ],
	\ 'vim': ['██╗     ██╗ ██╗ ███╗   ███╗',
	\         ' ██╗   ██╔╝ ██║ ████╗ ████║',
	\         '  ██╗ ██╔╝  ██║ ██╔████╔██║',
	\         '   ████╔╝   ██║ ██║╚██╔╝██║',
	\         '    ██╔╝    ██║ ██║ ╚═╝ ██║',
	\         '    ╚═╝     ╚═╝ ╚═╝     ╚═╝'
	\        ],
	\ }

let s:animals = {
	\ 'cow': ['       o',
	\         '        o   ^__^',
	\         '         o  (oo)\_______',
	\         '            (__)\       )\/\',
	\         '                ||----w |',
	\         '                ||     ||',
	\         ],
	\ 'lion': ['       o',
	\          '        o    ____',
	\          '         o  /    \',
	\          '           | ^__^ |',
	\          '           | (oo) |______',
	\          '           | (__) |      )\/\',
	\          '            \____/|----w |',
	\          '                 ||     ||'
	\          ],
	\ 'moose': ['       o',
	\           '        o   \_\_    _/_/',
	\           '         o      \__/',
	\           '                (oo)\_______',
	\           '                (__)\       )\/\',
	\           '                    ||----w |',
	\           '                    ||     ||'
	\           ],
	\ }

let g:startify_fortune_use_unicode = 1
let g:startify_session_dir = g:location_prefix.'/nvim/tmp/sessions'

if strftime('%M') % 3 == 0
	let s:greeting = startify#fortune#boxed()
elseif strftime('%M') % 3 == 1
	let s:greeting = s:greetings['hello']
else
	if has('nvim')
		let s:greeting = s:greetings['neovim']
	else
		let s:greeting = s:greetings['vim']
	endif
endif

if strftime('%H') < 12
	let s:animal = s:animals['cow']
elseif strftime('%H') < 18
	let s:animal = s:animals['lion']
else
	let s:animal = s:animals['moose']
endif
let g:startify_custom_header = map(s:greeting + s:animal, "\"   \".v:val")


" ===============
" === Rainbow ===
" ===============
nnoremap <leader>rb :RainbowToggle<CR>
let g:rainbow_active = 1

let g:rainbow_conf = {
	\ 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\ 'cgtermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\ 'ogperators': '_,_',
	\ 'pgarentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\ 'sgeparately': {
		\ '*': {
			\ 'parentheses': ['start=/「/ end=/」/', 'start=/『/ end=/』/'],
		\ },
		\ 'tex': {
			\ 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
		\ },
		\ 'lisp': {
			\ 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
		\ },
		\ 'vim': {
			\ 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
		\ },
		\ 'html': {
			\ 'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
		\ },
		\ 'css': 0,
	\ }
\ }


" =====================
" === EnhancedJumps ===
" =====================
let g:stopFirstAndNotifyTimeoutLen = 500 "跳转缓冲区的警告的时长(ms)
let g:EnhancedJumps_CaptureJumpMessages = 0
"noremap g, g;
"noremap g. g,


" =====================
" === vim-signature ===
" =====================
let g:SignatureMarkTextHLDynamic = 1 "highlight works with vim-gitgutter


" ================
" === Firenvim ===
" ================
if exists('g:started_by_firenvim')
	"nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
	au BufEnter github.com_*.txt set filetype=markdown
	au BufEnter stackoverflow.com_*.txt set filetype=markdown
	"auto save changes to page
	"autocmd TextChanged * ++nested write
	"autocmd TextChangedI * ++nested write
endif

let g:firenvim_config = {
	\ 'globalSettings': {
		\ 'alt': 'all',
		\ '<C-w>': 'noop',
		\ '<C-n>': 'noop',
		\ '<C-t>': 'noop',
	\  },
	\ 'localSettings': {
		\ '.*': {
			\ 'cmdline': 'firenvim',
			\ 'priority': 0,
			\ 'selector': 'textarea, div[role="textbox"]',
			\ 'takeover': 'never',
		\ },
	\ }
\ }


" ===================== End of Plugin Settings =====================
