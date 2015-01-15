function! s:ExecuteHGInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'leftabove vert new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nofile bufhidden=delete nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  "silent! execute 'resize ' . line('$')
  silent! redraw
  "silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

function! s:HGBlame()
	let currline = line(".") 
	let currwin  = winnr() 
	" set noscrollbind 
	set scrollbind 

	call s:ExecuteHGInShell('hg annotate -u -v -n %')
	syncbind 
	execute "normal!" . (col('$') + (&number ? &numberwidth : 0)). "\<c-w>|"
	silent! execute ':' . currline
	"silent! execute 'execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
endfunction

command! -complete=shellcmd Blame call s:HGBlame()

"show hg diff, when commiting
function! HgCommitDiff()
    "In .hgrc editor option I call vim "+HgCiDiff()"
    "It opens new split with diff inside
    rightbelow  vnew
    setlocal buftype=nofile
    :.!hg diff
    setlocal ft=diff
    wincmd p
    setlocal spell spelllang=en_us
    cnoremap wq wqa
    cnoremap q qa
    start
endfunction

command! -nargs=* HgCommitDiff call HgCommitDiff()

