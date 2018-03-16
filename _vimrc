""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on					" 文件类型检测
winpos 480 200          	" 设定窗口位置
set shortmess=atI   		" 去掉欢迎界面
"set lines=40 columns=155   " 设定窗口大小
set tabstop=2               " 设置tab键的宽度
set autoindent              " 自动对齐
set nu!              		" 显示行号
"set number					" 显示行号
set relativenumber			" 显示相对行号
set mouse=a                 " 启用鼠标
set ruler                   " 右下角显示光标位置的状态行
"set go=             		" 不要图形按钮
syntax enable               " 打开语法高亮
"syntax on					" 语法高亮	
colorscheme monokai     	" 设置背景主题 
set guifont=Consolas:h20    " 字体与字号
"set confirm				" 没有保存或文件只读时弹出确认
"set showcmd				" 输入的命令显示出来，看的更清楚？？没反应
"set foldenable				" 允许折叠??没反应
"set background = dark		" 背景黑色？？设置时报错
set showmatch				" 高亮显示匹配括号
set linebreak
set scrolloff=1				" 在光标前后至少显示一行

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 输入相关  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smartindent   			" 设置智能缩进
set autowrite				" 自动保存
"set cursorline				" 突出显示当前行
set clipboard+=unnamed      " 复制粘贴，共享window剪贴板

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码相关
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
	set fileencoding=chinese
else
    set fileencoding=utf-8
endif
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索相关
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase 				" 搜索忽略大小写
set incsearch				" 即时搜索，不用按回车

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start  " backspace问题
let mapleader=","				" 设置<leader>
behave mswin

" set undodir=$home/.undofile
" 不生成临时文件
" set noundofile				" 不生成undo文件
set nobackup				"不需要备份
set noswapfile 

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle插件管理
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$home/vimfiles/bundle/Vundle.vim/
call vundle#begin('$home/vimfiles/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

""""""""""""""""" 使用Vundle管理插件(必须) """"""""""""""""
Plugin 'VundleVim/Vundle.vim'

""""""""""""""""" 支持的插件安装格式 """"""""""""""""
""""""""""""""""" 插件命令要在begin和end之间 """"""""""""""""

"""""""""""""""" github仓库中的插件，格式为：Plugin '用户名/插件仓库名' """"""""""""""""
Plugin 'tpope/vim-fugitive'
" 自动补全插件
" Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-sensible'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 光标移动插件
Plugin 'Lokaltog/vim-easymotion'
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""" 来自http://vim-scripts.org/vim/scripts.html的插件 """"""""""""""""
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'

"""""""""""""""" git repos on your local machine本地仓库 (i.e. when working on your own plugin) """"""""""""""""
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

"""""""""""""""" 安装不同版本插件时避免命名冲突的方式 """"""""""""""""
" Plugin 'ascenator/L9', {'name': 'newL9'}

"""""""""""""""" 我的插件 """"""""""""""""
" Ctrlp
Plugin 'kien/ctrlp.vim'
" 设置ctrlp的快捷方式 ctrp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" 所有插件都要在这一行之前添加
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""