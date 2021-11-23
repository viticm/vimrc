#!/bin/bash
#yum -y install lua-devel
[[ 0 -ne $? ]] && exit 1
./configure --enable-gui=auto --enable-cscope --enable-multibyte \
  --enable-xim --enable-fontset --with-features=huge \
  --enable-luainterp --enable-pythoninterp --enable-sniff \
  --with-python-config-dir=/usr/lib64/python2.7/config/ \
  --enable-python3interp=yes \
  --with-python3-config-dir=/usr/lib64/python3.9/config-3.9-x86_64-linux-gnu/ \
  –-enable-fail-if-missing \
  --with-lua-prefix=/usr/local
  #--enable-pythoninterp \
  #--enable-rubyinterp --enable-perlinterp

# for deoplete.nvim
sudo pip3 install --user pynvim
