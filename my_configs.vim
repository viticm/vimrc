"not left margin
set foldcolumn=0

"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

"myself config
set cinoptions=s,e0,n0,f0,{0,}0,^0,:s,=s,l0,b0,gs,hs<Plug>PeepOpens,ts,is,+s,
set cinoptions+=c3,C0,/0,(2s,us,U0,w0,W0,m0,j0,)20,*30
set ts=2
set sw=2
set nowrap
set colorcolumn=80
set nu
map <F4> :NERDTreeToggle<cr>
map <F11> :!./mk_tags<CR>
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap csr :cs reset <C-R>=expand("<cword>")<CR><CR>

"set hidden
set switchbuf="useopen"

"color
color evening

"set SuperTab
let g:SuperTabCrMapping=1
let g:SuperTabDefaultCompletionType="context"

"set head file path
set path=.,,
set path+=/usr/include
set path+=/usr/local/include
set path+=~/**

let g:neocomplcache_enable_at_startup=1

"split color
hi VertSplit term=bold cterm=bold gui=bold
hi StatusLine term=bold,underline cterm=underline,bold gui=bold, ctermfg=yellow
hi StatusLineNC term=bold,underline cterm=underline,bold gui=bold, ctermfg=yellow
