#!/bin/bash
#the vimrc install script
#@version 1.0
#@author viticm<viticm.ti@gmail.com>
#@date 2013-12-14

currentdir=`pwd`

pluginslist="
auto-pairs https://github.com/jiangmiao/auto-pairs
ale https://github.com/dense-analysis/ale
vim-yankstack https://github.com/maxbrunsfeld/vim-yankstack
ack.vim https://github.com/mileszs/ack.vim
bufexplorer https://github.com/jlanzarotta/bufexplorer
ctrlp.vim https://github.com/ctrlpvim/ctrlp.vim
mayansmoke https://github.com/vim-scripts/mayansmoke
nerdtree https://github.com/preservim/nerdtree
nginx.vim https://github.com/chr4/nginx.vim
open_file_under_cursor.vim https://github.com/amix/open_file_under_cursor.vim
tlib https://github.com/tomtom/tlib_vim
vim-addon-mw-utils https://github.com/MarcWeber/vim-addon-mw-utils
vim-bundle-mako https://github.com/sophacles/vim-bundle-mako
vim-coffee-script https://github.com/kchmck/vim-coffee-script
vim-colors-solarized https://github.com/altercation/vim-colors-solarized
vim-indent-object https://github.com/michaeljsmith/vim-indent-object
vim-less https://github.com/groenewege/vim-less
vim-pyte https://github.com/therubymug/vim-pyte
vim-snipmate https://github.com/garbas/vim-snipmate
vim-snippets https://github.com/honza/vim-snippets
vim-surround https://github.com/tpope/vim-surround
vim-expand-region https://github.com/terryma/vim-expand-region
vim-multiple-cursors https://github.com/terryma/vim-multiple-cursors
vim-fugitive https://github.com/tpope/vim-fugitive
vim-rhubarb https://github.com/tpope/vim-rhubarb
goyo.vim https://github.com/junegunn/goyo.vim
vim-zenroom2 https://github.com/amix/vim-zenroom2
vim-repeat https://github.com/tpope/vim-repeat
vim-commentary https://github.com/tpope/vim-commentary
vim-gitgutter https://github.com/airblade/vim-gitgutter
gruvbox https://github.com/morhetz/gruvbox
vim-flake8 https://github.com/nvie/vim-flake8
vim-pug https://github.com/digitaltoad/vim-pug
lightline.vim https://github.com/itchyny/lightline.vim
lightline-ale https://github.com/maximbaz/lightline-ale
vim-abolish https://github.com/tpope/vim-abolish
rust.vim https://github.com/rust-lang/rust.vim
vim-markdown https://github.com/plasticboy/vim-markdown
vim-gist https://github.com/mattn/vim-gist
vim-ruby https://github.com/vim-ruby/vim-ruby
typescript-vim https://github.com/leafgarland/typescript-vim
vim-javascript https://github.com/pangloss/vim-javascript
vim-python-pep8-indent https://github.com/Vimjas/vim-python-pep8-indent
vim-indent-guides https://github.com/nathanaelkane/vim-indent-guides
mru.vim https://github.com/vim-scripts/mru.vim
editorconfig-vim https://github.com/editorconfig/editorconfig-vim
dracula https://github.com/dracula/vim
deoplete.nvim https://github.com/Shougo/deoplete.nvim
vim-dispatch https://github.com/tpope/vim-dispatch
vim-projectionist https://github.com/tpope/vim-projectionist
vim-vue https://github.com/posva/vim-vue
syntastic https://github.com/vim-syntastic/syntastic
eslint-plugin-vue https://github.com/vuejs/eslint-plugin-vue
papercolor-theme https://github.com/NLKNguyen/papercolor-theme
vim-hug-neovim-rpc https://github.com/roxma/vim-hug-neovim-rpc
vim-go https://github.com/fatih/vim-go
nvim-yarp https://github.com/roxma/nvim-yarp
vim-devicons https://github.com/ryanoasis/vim-devicons
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
  local message=${@}
  echo -e "\e[0;31;1merror: ${message}\e[0m"
  exit 1
}

#print warning message, yellow words
#@param message
#@return void
function warning_message() {
  local message=${@}
  echo -e "\e[0;33;1mwarning: ${message}\e[0m"
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

#fix some bug for all
#@param string vim runtimepath
#@return void
function fixbug() {
  local runtimepath=${1}
  if [[ "" != $runtimepath ]] ; then
    sed -i 's;!nerdtree#runningWindows();nerdtree#runningWindows();g' \
      ${runtimepath}/sources_non_forked/nerdtree/plugin/NERD_tree.vim
  fi
}

#update vimrc(amix)
#@param void
#@return void
function vimrc() {
  local gitstatus=`find ./ -maxdepth 1 -type d -name .git`
  local tmpdir="${HOME}/tmp_vimrc"
  if [[ "" != $gitstatus ]] ; then
    git pull --rebase
  else
    git clone git://github.com/amix/vimrc.git $tmpdir
    cp -r $tmpdir/* ./
  fi
  rm -rf $tmpdir
  fixbug ./
}

#full install vimrc
#@param void
#@return void
function plugin() {
  python update_plugins.py
  if [[ 0 == $? ]] ; then
    exit 0
  fi
#if python update failed, then use shell update
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
        cp -r ${tmpdir}/${pluginname} ${plugindir}
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
  fixbug ./
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
