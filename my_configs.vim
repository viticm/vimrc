"""
 " VIM RUN CONFIG ( https://github.com/viticm/vimrc )
 " $Id my_configs.vim
 " @link https://github.com/viticm/vimrc for the canonical source repository
 " @copyright Copyright (c) 2020 viticm( viticm.ti@gmail.com )
 " @license
 " @user viticm( viticm.ti@gmail.com )
 " @date 2020/05/15 09:51
 " @uses Some diffrent config for user
"""

"not left margin
set foldcolumn=0

"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''
map <F7> :%s/;$//g<cr>:noh<cr>''

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

let s:vproject_info = {}
if filereadable('.vproject.json')
  let s:buf = ''
  for line in readfile('.vproject.json')
    let s:buf .= line
  endfor
  let s:vproject_info = json_decode(s:buf)
  unlet s:buf
endif

"add source file description
map <F6> :call GenerateFileDecription()<cr>

"get current directory
function! s:GetPWD()
    return substitute(getcwd(), "", "", "g")
endfunction

"get current directory name
function! s:GetCurDirName()
  let cur_path = substitute(getcwd(), "", "", "g")
  if "/" == cur_path 
    return ""
  endif
  let pos = strridx(cur_path, '/')
  return strpart(cur_path, pos + 1)
endfunction

let s:cur_dir_name = s:GetCurDirName()

let s:framework_list = {'plain': 1}

"get the project
function! s:GetProjectName()
  if has_key(s:vproject_info, 'name')
    return s:vproject_info.name
  else
    let r = s:GetCurDirName()
    let first_pos = stridx(r, '-')
    let first_name = strpart(r, 0, first_pos)
    let r = tr(r, '-', ' ')
    if has_key(s:framework_list, first_name)
      let r = first_name.' FRAMEWORK '.strpart(r, first_pos + 1)
    end
    return toupper(r)
  endif
endfunction

"get the project uri
function! s:GetProjectURI()
  if has_key(s:vproject_info, 'uri')
    return s:vproject_info.uri
  else
    return "https://github.com/viticm/".s:cur_dir_name
  endif
endfunction

"get the project author
function! s:GetProjectAuthor()
  if has_key(s:vproject_info, 'author')
    return s:vproject_info.author
  else
    return "viticm( viticm.ti@gmail.com )"
  endif
endfunction

let s:p_name = s:GetProjectName() "project name
let s:p_author = s:GetProjectAuthor() "project author
let s:p_uri = s:GetProjectURI() "project uri

"Add file decription.
function! s:AddFileDecription(add_line, notechar)
  let begin = "/**"
  let body = " * "
  let end = " */"
  if "-" == a:notechar
    let begin = "--[["
    let body = " - "
    let end = "--]]"
  elseif "<" == a:notechar
    let begin = "<!--"
    let body = " - "
    let end = "-->"
  elseif '"' == a:notechar
    let begin = '"""'
    let body = ' " '
    let end = '"""'
  endif
  call append(0 + a:add_line, begin)
  call append(1 + a:add_line, body.s:p_name." ( ".s:p_uri." )")
  call append(2 + a:add_line, body."$Id ".expand("%:t"))
  call append(3 + a:add_line, body."@link ".s:p_uri." for the canonical source repository")
  call append(4 + a:add_line, body."@copyright Copyright (c) ".strftime("%Y")." ".s:p_author)
  call append(5 + a:add_line, body."@license")
  call append(6 + a:add_line, body."@user ".s:p_author)
  call append(7 + a:add_line, body."@date ".strftime("%Y/%m/%d %H:%M"))
  call append(8 + a:add_line, body."@uses your description")
  call append(9 + a:add_line, end)
  echohl WarningMsg | echo "Successful in adding the source file decription." | echohl None
endfunction

"update source file description
function! s:UpdateFileDecription(notechar)
  let notechar = a:notechar
  if '"' == notechar
    let notechar = '\"'
  end
  normal m'
  execute '/ '.notechar.' @date /s@.*$@\=" '.notechar.' \@date ".strftime("%Y/%m/%d %H:%M")@'
  normal ''
  normal mk
  execute '/ '.notechar.' $Id /s@.*$@\=" '.notechar.' $Id ".expand("%:t")@'
  execute "noh"
  normal 'k
  echohl WarningMsg | echo "Successful in updating the source file description." | echohl None
endfunction

"generate source file decription
function! GenerateFileDecription()
  let add_line = 0
  let extend_name = expand("%:e") "for diffrent file type
  let notechar = "*"
  if extend_name == "php"
    let add_line = 1
  endif
  if "lua" == extend_name
    let notechar = "-"
  elseif "vue" == extend_name
    let notechar = "<"
  elseif "vim" == extend_name
    let notechar = '"'
  endif
  let check_line = 6 + add_line
  let line = getline(check_line)
  let str = ' '.notechar.' @license'
  if line == str
    call s:UpdateFileDecription(notechar)
    return
  endif
  call s:AddFileDecription(add_line, notechar)
endfunction
"set filetype for extends files
"au BufRead,BufNewFile *.txt set filetype=lua
autocmd FileType php set ts=4
autocmd FileType php set sw=4
autocmd FileType php set expandtab
autocmd FileType php set autoindent
autocmd FileType php set colorcolumn=120


"For c++11, if you want check in source then open it.
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++17 -stdlib=libc++'
