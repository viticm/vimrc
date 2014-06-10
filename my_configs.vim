""" version: 1.1
""" author: viticm(viticm.ti@gmail.com)
""" date: 2014-5-20

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
map <F11> :!sh ./mk_tags<CR>
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

"for cscope
nmap fc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap fs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap fg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap fc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap ft :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap fe :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap ff :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap fd :cs find d <C-R>=expand("<cword>")<CR><CR>

if has("cscope")
  "set csprg=/usr/bin/cscope
  set csto=1
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

"for taglist
let g:Tlist_Use_Right_Window = 1
let g:Tlist_Enable_Fold_Column = 0
let g:Tlist_Exit_OnlyWindow = 1
map <F9> :Tlist<CR>

"NERD Tree
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=31


"neocomplete
let g:neocomplete#enable_at_startup = 1
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#include#max_processes = 0
map <F10> :NeoCompleteToggle<CR>

"multi language
if has("multi_byte") 
  "utf-8
  set termencoding=utf-8 
  set formatoptions+=mM 
  set fencs=utf-8,gbk 
  
  "file codings
  set encoding=utf-8
  set fileencodings=ucs-bom,utf-8,cp936,gbk,gb2312
 
  if v:lang =~? '^/(zh/)/|/(ja/)/|/(ko/)' 
     set ambiwidth=double 
  endif 
  if has("win32") 
    source $VIMRUNTIME/delmenu.vim 
    source $VIMRUNTIME/menu.vim 
    language messages zh_CN.utf-8 
  endif 
else 
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte" 
endif

"add source file description
map <F3> :call TitleDet()<cr>'s
function add_file_decription()
  call append(0, "/**")
  call append(1, " * PAP Engine ( https://github.com/viticm/pap )")
  call append(2, " * $Id ".expand("%:t"))
  call append(3, " * @link https://github.com/viticm/pap for the canonical source repository")
  call append(4, " * @copyright Copyright (c) 2013-2013 viticm( viticm@126.com )")
  call append(5, " * @license")
  call append(6, " * @user viticm<viticm@126.com>")
  call append(7, " * @date ".strftime("%Y/%m/%d %H:%M"))
  call append(8, " * @uses your description")
  call append(9, " */")
  echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf

"update source file description
function update_file_decription()
  normal m'
  execute ' * @date /s@:.*$@\=strftime(":%Y-%m-%d %H:%M")@'
  normal ''
  normal mk
  execute ' * $Id /s@:.*$@\=":".expand("%:t")@'
  execute "noh"
  normal 'k
  echohl WarningMsg | echo "Successful in updating the source file description." | echohl None
endfunction

"generate file decription
function generate_file_decription()
    let n = 2
    "Ä¬ÈÏÎªÌí¼Ó
        let line = getline(n)
        let str = '^#       COPYRIGHT NOTICE$'
        if line =~ str
            call UpdateTitle()
            return
        endif
    call AddTitle()
endfunction