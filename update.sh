#!/bin/bash
#the vimrc install script
#@version 1.0
#@author viticm<viticm.ti@gmail.com>
#@date 2013-12-14

currentdir=`pwd`

pluginslist="
ack.vim https://github.com/mileszs/ack.vim
bufexplorer https://github.com/corntrace/bufexplorer
ctrlp.vim https://github.com/kien/ctrlp.vim
mayansmoke https://github.com/vim-scripts/mayansmoke
nerdtree https://github.com/scrooloose/nerdtree
nginx.vim https://github.com/vim-scripts/nginx.vim
open_file_under_cursor.vim https://github.com/amix/open_file_under_cursor.vim
snipmate-snippets https://github.com/scrooloose/snipmate-snippets
taglist.vim https://github.com/vim-scripts/taglist.vim
tlib https://github.com/vim-scripts/tlib
vim-addon-mw-utils https://github.com/MarcWeber/vim-addon-mw-utils
vim-bundle-mako https://github.com/sophacles/vim-bundle-mako
vim-coffee-script https://github.com/kchmck/vim-coffee-script
vim-colors-solarized https://github.com/altercation/vim-colors-solarized
vim-indent-object https://github.com/michaeljsmith/vim-indent-object
vim-less https://github.com/groenewege/vim-less
vim-markdown https://github.com/tpope/vim-markdown
vim-pyte https://github.com/therubymug/vim-pyte
vim-snipmate https://github.com/garbas/vim-snipmate
vim-snippets https://github.com/honza/vim-snippets
vim-surround https://github.com/tpope/vim-surround
vim-expand-region https://github.com/terryma/vim-expand-region
vim-multiple-cursors https://github.com/terryma/vim-multiple-cursors
vim-fugitive https://github.com/tpope/vim-fugitive
vim-airline https://github.com/bling/vim-airline
vimerl https://github.com/jimenezrick/vimerl
"
clean_plugindir="no" #update plugin will delete the old dir

#help text, the script desc
#@param void
#@return void
function help_text() {
  cat <<EOF
${0} ver 1.0

options:
--vimrc  update new vimrc form github.com)
--plugin update all vim plugins form github.com
EOF
}

#print error message, red words
#@param string message
#@return void
function error_message() {
  local message=${1}
  echo -e "\e[0;31;1merror:${message}\e[0m"
  exit 1
}

#print warning message, yellow words
#@param message
#@return void
function warning_message() {
  local message=${1}
  echo -e "\e[0;33;1merror:${message}\e[0m"
}

#get format path
#param string path
#return string
function getpath() {
  local path=${1}
  local newpath=${path}
  if [[ "~" == ${path:0:1} ]] ; then
    newpath=`echo ${path} | sed "s;~;${HOME};"`
  fi
  echo ${newpath}
}

#update vimrc(amix)
#@param void
#@return void
function vimrc() {
  local gitstatus=`find ./ -type d -name .git`
  local tmpdir="${HOME}/tmp_vimrc"
  if [[ "" != $gitstatus ]] ; then
    git pull --rebase
  else
    git clone git://github.com/amix/vimrc.git $tmpdir
    cp $tmpdir/* ./ -r
  fi
  rm -rf $tmpdir
}

#full install vimrc
#@param void
#@return void
function plugin() {
  python update_plugins.py
  if [[ 0 == $? ]] ; then
    exit 0
  fi
#if python update if failed, then use shell update
  warning_message "python update plugin failed, now use shell"
  tmpdir="${currentdir}/tmp_plugin"
  rm -rf $tmpdir
  i=1
  local pluginname=""
  local pluginurl=""
  for plugin in $pluginslist; do
    if [[ 0 == $(($i%2)) ]] ; then
      pluginurl=$plugin
      check=`echo $pluginurl | grep $pluginname`
      if [[ $? != 0 ]] ; then #grep match ok return 0 else 1
        rm -rf $tmpdir
        error_message "plugin url${pluginurl} not found the name"
      fi
      plugindir="${currentdir}/sources_non_forked/"

      echo "update ${pluginname}"
      if [[ ! -d ${plugindir}/${pluginname}/.git ]] ; then
        mkdir -p ${tmpdir}
        cmd=`cd $tmpdir && git clone $pluginurl`
        cp ${tmpdir}/${pluginname} ${plugindir} -r
      else
        cmd=`cd $plugindir/${pluginname} && git pull`
      fi
      echo "update ${pluginname} end"
    else
      pluginname=$plugin
    fi
    ((++i))
  done
  echo -e "all plugins is update"
  rm -rf $tmpdir
}

#the script main function, like c/c++
function main() {
  cmd=${1}
  case "${cmd}" in
    --help ) help_text;;
    -h) help_text;;
    --vimrc) vimrc;;
    --plugin) plugin;;
  esac
}
if [[ "" == ${@} ]] ; then
  error_message "${0}: no commond specified.You can use <${0} --help> 
                get parameters for this script."
else
  main "${@}"
  exit 0
fi
