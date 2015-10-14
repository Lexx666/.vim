" .vimrc by Tom Schoenlau
"==================================================================
"==========================BASICS==================================
"==================================================================

"load plugins from bundle/plugin
execute pathogen#infect()
call pathogen#helptags()

set nocp	"cursors in edit-mode
set backspace=2 "backspace in edit mode
set wildmenu

"================searching=================
set ignorecase  "ignore case when searching

set sidescroll=20
set scrolloff=10
set sidescrolloff=20

" enable mouse (seems to disable ability to copy (SHIFT-CTRL-C))
" set mouse=a

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).

" autocmd BufReadPost *
" \ if line("'\"") > 0 && line("'\"") <= line("$") |
" \   exe "normal g`\"" |
" \ endif
" au BufWinLeave *.* mkview
" if argc()
" 	au BufWinEnter *.* silent loadview
" endif

" Remind position of curser in file for next start of this file
augroup resCur
	autocmd!
	autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END



"to enable copy and paste via ctrl-c ctrl-v in gvim
"if has("gui_running")	
"	source $VIMRUNTIME/mswin.vim
"	behave mswin
"endif

"windowsize
"set lines=60 columns=120


"Note background set to dark in .vimrc
highlight Normal     guifg=gray guibg=black

"===wordwrap===
set nowrap
set lbr			"Sets linebreak, so words are not split when wrap is on

"=======encoding=======
set fileencoding=latin1
set fileencodings=latin1,utf-8
set encoding=UTF-8

"=======nice statusline==========
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [HEX=\%02.2B]\ [POS=%l,%v][%p%%]\ [LEN=%L] 
"and always display status
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#whitespace#enabled = 0
" let g:airline_section_warning = ''


" color statusline on insert
:au InsertEnter * hi StatusLine ctermfg=green guifg=green
:au InsertLeave * hi StatusLine ctermfg=yellow guifg=yellow

"=======vim-powerline==========
" to enable fancy symbols just execute: cd ~/.fonts/ && git clone https://github.com/scotu/ubuntu-mono-powerline.git && cd ~
" let g:Powerline_symbols = 'fancy'

"=============TABS==============
set autoindent		"autoindention
set smartindent		"autoindention
set shiftwidth=4
set tabstop=4
"set softtabstop=0
"==================================================================
"==============================COLOR===============================
"==================================================================
set t_Co=256
set background=dark
colorscheme koehler

"==================================================================
"==============================KEYMAPS=============================
"==================================================================

cmap Q q
cmap W w

"clone lines with up and down
map <c-down> :t.<CR>
imap <c-down> <ESC>:t.<CR>i
map <c-up> :t.<CR><up>
imap <c-up> <ESC>:t.<CR><up>i

"move lines with up and down
map <s-down> :m+1<CR>==
imap <s-down> <ESC>:m+1<CR>==gi
vmap <s-down> :m'>+1<CR>gv=gv

map <s-up> :m-2<CR>==
imap <s-up> <ESC>:m-2<CR>==gi
vmap <s-up> :m-2<CR>gv=gv

" indent with arrowkeys
map <S-Right> >>^
imap <S-Right> <ESC>>>^i
vmap <S-Right> >><ESC>gv

map <S-Left> <<^
imap <S-Left> <ESC><<^i
vmap <S-Left> <<<ESC>gv

"==================================================================
"=============================NERDTree=============================
"==================================================================
nnoremap <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"==================================================================
"==========================CTAGS===================================
"==================================================================

"ctags file location
"set tags+=~/public_html/cdp-src/tags
function SetTags()
	let s:curdir = getcwd()

	while !filereadable("tags") && getcwd() != "/"
		cd ..
	endwhile

	if filereadable("tags")
		execute "set tags=" . getcwd() . "/tags"
	endif

	execute "cd " . fnameescape(s:curdir)
endfunction

call SetTags()

"ctags. jump to function
map tt g<C-]>

"-------- taglist plugin-----------
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Exit_OnlyWindow = 1

map <c-f> :TlistToggle <CR>
imap <c-f> <ESC>:TlistToggle <CR>i

" only display classes and functions in Taglist
let tlist_php_settings = 'php;c:class;f:function'


"==================================================================
"===========================TEXTBLOCKS=============================
"==================================================================
"-----comment with datestamp
nnoremap <c-c> A // [] Tom Schoenlau (u_40) <ESC>"=strftime("%Y-%m-%d")<CR>p==A: 
inoremap <c-c> <ESC>A // [] Tom Schoenlau (u_40) <ESC>"=strftime("%Y-%m-%d")<CR>p==A: 
"-----insert simple datestamp
nnoremap <c-z> <ESC>"=strftime("%Y-%m-%d %H:%M:%S")<CR>pA 
inoremap <c-z> <ESC>"=strftime("%Y-%m-%d %H:%M:%S")<CR>pA 

"==================================================================
"===========================PHP DOC================================
"==================================================================
"source ~/.vim/php-doc.vim
inoremap <C-d> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-d> :call PhpDocSingle()<CR>
vnoremap <C-d> :call PhpDocRange()<CR>


"==================================================================
"===========================VIM Help===============================
"==================================================================
"map � <C-]>
"map � <C-O>

"==================================================================
"==========================QUICK PAIRS=============================
"==================================================================
let mapleader="�"
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>{ {<ESC>o}<ESC><up>o
imap <leader>[ []<ESC>i

"==================================================================
"==========================EasyAlign===============================
"==================================================================
vmap <Enter> <Plug>(EasyAlign)

"==================================================================
"===========================Complition=============================
"==================================================================
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"=============================ultisnips============================
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-v>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
