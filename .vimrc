
"--------------------------
" Start Neobundle Settings.
"---------------------------
" bundle�ŊǗ�����f�B���N�g�����w��
 
" Required:
if has('win32') || has('win64')
	set runtimepath+=$USERPROFILE/.vim/bundle/neobundle.vim/
	call neobundle#begin(expand('$USERPROFILE/.vim/bundle/'))
else
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	call neobundle#begin(expand('~/.vim/bundle/'))
endif
" neobundle���̂�neobundle�ŊǗ�
NeoBundleFetch 'Shougo/neobundle.vim'

" Common
NeoBundle 'tyru/restart.vim'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/vimproc'

" Memo
NeoBundle 'glidenote/memolist.vim'

" Script Quick Test
NeoBundle 'thinca/vim-quickrun'

" File handling
NeoBundle 'Shougo/unite.vim'
NeoBundle 'mbbill/VimExplorer'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'kmnk/vim-unite-giti.git'

" Writting Support
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tomtom/tcomment_vim.git'
NeoBundle 'nathanaelkane/vim-indent-guides'

"Markdown
NeoBundle 'godlygeek/tabular'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

"Visualize
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'

call neobundle#end()
 
" Required:
filetype plugin indent on
 
" ���C���X�g�[���̃v���O�C��������ꍇ�A�C���X�g�[�����邩�ǂ�����q�˂Ă����悤�ɂ���ݒ�B���񕷂����Ǝז��ȏꍇ������̂ŁA���̐ݒ�͔C�ӁB
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------


"==================================
" NeoBundle Plugin Settings 
"==================================

"QuickRun{{{
	let g:quickrun_config={'*': {'split':''}}
	let g:quickrun_config={'*': {'hook/time/enable': 1},}
"}}}

"memolist{{{
	let g:memolist_qfixgrep = 1
"}}}

"vimfiler{{{
	if has('win32') || has('win64')
		let g:vimfiler_data_directory = 'G:\tmp\.vimfiler'
	endif
	let g:vimfiler_as_default_explorer = 1
	let g:vimfiler_safe_mode_by_default = 0
	 
	"�f�t�H���g�̃L�[�}�b�s���O��ύX
	nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
	nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
	augroup vimrc
	  autocmd FileType vimfiler call s:vimfiler_my_settings()
	augroup END
	function! s:vimfiler_my_settings()
	  nmap <buffer> q <Plug>(vimfiler_exit)
	  nmap <buffer> Q <Plug>(vimfiler_hide)
	endfunction

"}}}

"indent-guide{{{
	let g:indent_guides_enable_on_vim_startup = 1
"}}}

"unite-outline{{{
	let g:unite_winwidth = 40
	let g:unite_split_rule = "rightbelow"
	nnoremap <silent> <Leader>o :<C-u>Unite -vertical -no-quit outline<CR>
"}}}

"==================================
" General 
"==================================
set noswapfile
set nobackup
set tabstop=4
set shiftwidth=4
set clipboard+=unnamed  "Enable Windows Clipbord
set background=dark
set nonumber
set splitbelow "�V�����E�B���h�E�����ɊJ��
set splitright "�V�����E�B���h�E���E�ɊJ��



if ($ft=='python')
	colorscheme Tomorrow-Night
else
	colorscheme hybrid
endif




