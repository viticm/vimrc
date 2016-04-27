#!/bin/bash
#the vimrc install script
#@version 1.0
#@author viticm<viticm.ti@gmail.com>
#@date 2013-12-14

currentdir=`pwd`
#help text, the script desc
#@param void
#@return void
function help_text() {
  cat <<EOF
${0} ver 1.0

options:
--base   install base vim config(base plugin)
--full   install full vim config(all use plugin)
--help   view the text, or just use -h
--update update all amix vimrc to git(just for me)
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
#@return string void
function warning_message() {
  local message=${@}
  echo -e "\e[0;33;1mwarning: ${message}\e[0m"
}

#fix some bug for all
#@param string vim runtimepath
#@return void
function fixbug() {
  local runtimepath=${1}
  local is_win32=false
  if [[ `uname | grep W32_NT` != "" ]] ; then
    is_win32=true
  fi

  if [[ "" != $runtimepath ]] ; then
    if ! $is_win32 ; then #bug of linux
      sed -i 's;!nerdtree#runningWindows();nerdtree#runningWindows();g' \
        ${runtimepath}/sources_non_forked/nerdtree/plugin/NERD_tree.vim
    fi
  fi
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

#install base
#@param void
#@return void
function base() {
  local cmd_runtimepath=""
  local runtimepath=""
  local vimrcdir="amix-vimrc"
  local amixvimrc_url="https://github.com/amix/vimrc"
  [[ ! -d amix-vimrc ]] && git clone $amixvimrc_url $vimrcdir
  cmd_runtimepath="cat ${vimrcdir}/install_awesome_vimrc.sh | 
                  grep runtimepath | 
                  sed 's/.*runtimepath.*=//g'
                   "
  runtimepath=`echo ${cmd_runtimepath} | sh`
  runtimepath=`getpath ${runtimepath}`
  echo "Now clean your home vim files, rm -rf ~/.vim*, Ctrl+C to abort now"
  read answer
  rm -rf ${HOME}/*.vim
  rm -rf ${runtimepath}
  cp amix-vimrc ${runtimepath} -r
  sh ${runtimepath}/install_basic_vimrc.sh
  cp ${currentdir}/update.sh ${runtimepath}
  fixbug $runtimepath
}

#full install vimrc
#@param void
#@return void
function full() {
  local cmd_runtimepath=""
  local runtimepath=""
  local vimrcdir="amix-vimrc"
  local amixvimrc_url="https://github.com/amix/vimrc"
  [[ ! -d amix-vimrc ]] && git clone $amixvimrc_url $vimrcdir
  cmd_runtimepath="cat ${vimrcdir}/install_awesome_vimrc.sh | 
                  grep runtimepath | 
                  sed 's/.*runtimepath.*=//g'
                   "
  runtimepath=`echo ${cmd_runtimepath} | sh`
  runtimepath=`getpath ${runtimepath}`
  echo "Now clean your home vim files, rm -rf ~/.vim*, Ctrl+C to abort now"
  read answer
  rm -rf ${HOME}/*.vim
  rm -rf ${HOME}/.vim*
  rm -rf ${runtimepath}
  cp amix-vimrc ${runtimepath} -r
  sh ${runtimepath}/install_awesome_vimrc.sh
  cp ${currentdir}/my_configs.vim ${runtimepath}
  cp ${currentdir}/update.sh ${runtimepath}
  fixbug $runtimepath
}

#update vimrc
#@param void
#@return void
function update() {
  tmpdir="${currentdir}/tmp_vimrc"
  rm -rf ${tmpdir}
  git clone git://github.com/amix/vimrc.git ${tmpdir}
  rm -rf ${tmpdir}/.git
  cp ${tmpdir}/* amix-vimrc/ -r
  #rm -rf $tmpdir
  git add -A
  git commit -m "update the new amix vimrc"
  git push
}

#the script main function, like c/c++
function main() {
  cmd=${1}
  case "${cmd}" in
    --help ) help_text;;
    -h) help_text;;
    --base) base;;
    --full) full;;
    --update) update;;
  esac
}
if [[ "" == ${@} ]] ; then
  error_message "${0}: no commond specified.You can use <${0} --help> 
                get parameters for this script."
else
  main "${@}"
  exit 0
fi
