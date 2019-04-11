"http://lazybing.github.io/blog/2016/07/07/how-to-use-vim/#vim-fswitch
"https://github.com/yangyangwithgnu/use_vim_as_ide
set nocompatible              " required
filetype off                  " required

"set runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " vundle
Plugin 'tmhedberg/SimpylFold' "
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'Chiel92/vim-autoformat'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
" 这个插件可以显示文件的Git增删状态
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'majutsushi/tagbar'
"Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'kien/ctrlp.vim'
"https://github.com/octol/vim-cpp-enhanced-highlight
Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'vim-scripts/DfrankUtil'
"Plugin 'vim-scripts/vimprj'
"Plugin 'dyng/ctrlsf.vim'
Plugin 'derekwyatt/vim-fswitch'

call vundle#end()            " required
filetype plugin indent on    " required

" 常用的命令
" :PluginList - 列出所有已配置的插件 
" :PluginInstall - 安装插件,追加 `!` 用以更新或使用 
" :PluginUpdate " 
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件

"####################################################################


let mapleader=';'

"######################### fold ###################################

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable
"au BufWinLeave * silent mkview  " 保存文件的折叠状态
"au BufRead * silent loadview    " 恢复文件的折叠状态
"
"空格折叠
nnoremap <space> za           

"显示行号 关闭 :set nonumber
:set number


"tab & shift width
" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

    
"自动格式化 新系统需要安装 clang-format, autopep8, js0beautify, astyle
"https://github.com/Chiel92/vim-autoformat
noremap <F3> :Autoformat<CR>
let g:autoformat_verbosemode=0 "clang here I didn't add other formatter.

" Ctrl+N 打开/关闭
map <C-n> :NERDTreeToggle<CR>
" 当不带参数打开Vim时自动加载项目树
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 当所有文件关闭时关闭项目树窗格
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 不显示这些文件
let NERDTreeIgnore=['\.pyc$', '\~$', 'node_modules'] "ignore files in NERDTree
" 不显示项目树上额外的信息，例如帮助、提示什么的
let NERDTreeMinimalUI=1

"文件搜索
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip     
let g:ctrlp_custom_ignore = {'dir':  '\v[\/]\.(git|hg|svn)$', 'file': '\v\.(exe|so|dll)$'}

let g:ctrlp_match_window = 'results:20'
let g:ctrlp_max_files=0

set clipboard=unnamed
set pastetoggle=<F9>

"airline
"https://blog.csdn.net/panderang/article/details/54175475 总是显示状态栏
"https://blog.csdn.net/the_victory/article/details/50638810
"https://github.com/vim-airline/vim-airline
set laststatus=2
set t_Co=256
let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1
set guifont=Inconsolata\ 20
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
nnoremap <leader>1 :bn<CR>
nnoremap <leader>2 :bp<CR>
nnoremap <leader>3 :bd<CR>
"unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" panel navigators
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"
" " map keys for vertical/horizontal split panel
nnoremap <leader>vs <C-w>v
nnoremap <leader>hs <C-w>s
"
" " map keys for resize vertical/horizontal window:
nnoremap <silent> + :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> _ :exe "resize " . (winheight(0) * 3/4)<CR>
nnoremap <silent> > :exe "vertical resize " . (winwidth(0) * 4/3)<CR>
nnoremap <silent> < :exe "vertical resize " . (winwidth(0) * 3/4)<CR>

" 显示光标当前位置
set ruler
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch
"语法高亮
syntax enable
set background=dark
"colorscheme solarized
colorscheme molokai
"colorscheme phd
"colorscheme afterglow
highlight CursorLine   cterm=NONE ctermbg=24 ctermfg=NONE guibg=NONE guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=24 ctermfg=NONE guibg=NONE guifg=NONE

"缩进助手
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"You complete me 最难安装
"pre python echo has('python')
"for C -> libclang
"http://howiefh.github.io/2015/05/22/vim-install-youcompleteme-plugin/
"https://www.jianshu.com/p/d908ce81017a
set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口

inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
"回车即选中当前项 上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F6> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic"
"let g:ycm_global_ycm_extra_conf = '/home/tbt/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf = 0

" *.cpp 和 *.h 间切换
nmap <silent> <Leader>sw :FSHere<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cBursor calls
if has("cscope")

  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
	  cs add cscope.out
	  " else add database pointed to by environment
	  elseif $CSCOPE_DB != ""
		  cs add $CSCOPE_DB
	  endif
	  set csverb
endif
    

:nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
:nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
:nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

:nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
:nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
:nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
:nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
:nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
:nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
:nmap <C-@>i :scs find i <C-R>=expand("<cfile>")<CR><CR>
:nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


:nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
:nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
:nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
:nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
:nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
:nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
:nmap <C-@><C-@>i :vert scs find i <C-R>=expand("<cfile>")<CR><CR>
:nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"my button
noremap  <expr>0     col('.') == 1 ? '^': '0'
vmap <c-c> "+y
"立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
"专注
" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T
" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
	call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>
" 启动 vim 时自动全屏
autocmd VimEnter * call ToggleFullscreen()
"font gvim set guifont= 

