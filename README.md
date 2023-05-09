# The Ultimate vimrc(viticm)
## Install
    You can use the ./install.sh --help or -h to see the script params.
    - sh ./install.sh --full will install all plugin in your vim config.
    - sh ./install.sh --base just install base without plugins.
## Update
    update first use axim python and last use shell script.
    - First you will install vimrc(this) to your home.
    - To your vimrc dir, default ~/.vim_runtime(cd to it).
    - Use update script to update your vimrc or plugins.
    - sh ./update.sh --vimrc or sh ./update.sh --plugin

## Recommand the plugins(not include):
    - https://github.com/ycm-core/YouCompleteMe
    - After install vimrc the clone to .vim_runtime directory.
    - like: cd ~/.vim_runtime/sources_non_forked && git clone 
    - https://github.com/ycm-core/YouCompleteMe && cd YouCompleteMe
    - && python3 install.py
