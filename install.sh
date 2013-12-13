#!/bin/bash
currentdir=`pwd`
#help text, the script desc
#@param void
#@return void
function help_text() {
  echo -e "${0} ver 1.0 \n"
  echo "options:"
  echo "--base   install base vim config(base plugin)"
  echo "--full   install full vim config(all use plugin)"
  echo "--help   view the text, or just use -h"
  echo "--update update all amix vimrc to git(just for me) "
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

#install base
#@param void
#@return void
function base() {
  local cmd_runtimepath="cat amix-vimrc/install_awesome_vimrc.sh | 
                         grep runtimepath | 
                         sed 's/.*runtimepath.*=//g'"
  local runtimepath=`echo ${cmd_runtimepath} | sh`
  runtimepath=`getpath ${runtimepath}`
  rm -rf ${runtimepath}
  cp amix-vimrc ${runtimepath} -r
  sh ${runtimepath}/install_basic_vimrc.sh
  cp ${currentdir}/update.sh ${runtimepath}
}

#full install vimrc
#@param void
#@return void
function full() {
  local cmd_runtimepath="cat amix-vimrc/install_awesome_vimrc.sh | 
                        grep runtimepath | 
                        sed 's/.*runtimepath.*=//g'
                        "
  local runtimepath=`echo ${cmd_runtimepath} | sh`
  runtimepath=`getpath ${runtimepath}`
  rm -rf ${runtimepath}
  cp amix-vimrc ${runtimepath} -r
  sh ${runtimepath}/install_awesome_vimrc.sh
  cp ${currentdir}/my_configs.vim ${runtimepath}
  cp ${currentdir}/update.sh ${runtimepath}
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
  git add -A
  git commit -m "update the new amix vimrc"
  git push
  rm -rf $tmpdir
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
