#!/bin/bash
currentdir=`pwd`
#help text, the script desc
#@param void
#@return void
function help_text() {
  echo -e "${0} ver 1.0 \n"
  echo "options:"
  echo "--vimrc  update new vimrc form github.com)"
  echo "--plugin update all vim plugins form github.com(need python)"
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
    cp $tmpdir ./ -r
  fi
  rm -rf $tmpdir
}

#full install vimrc
#@param void
#@return void
function plugin() {
  python update_plugins.py
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
