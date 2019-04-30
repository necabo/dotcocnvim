#!/bin/bash

if ! ( hash git 2>/dev/null ); then
    echo "Please install git"
    exit 1
fi

DOTCOCNVIM=~/.cocnvim
NVIM=~/.config/nvim

echo "Drop all existing plugins?"
read -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf $DOTCOCNVIM/autoload
    curl -LSso $DOTCOCNVIM/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    rm -rf $DOTCOCNVIM/plugged
fi

echo "About to wipe your $NVIM."
read -p "Proceed? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf $NVIM
    rm ~/.local/share/nvim/rplugin.vim
    ln -s $DOTCOCNVIM $NVIM
    # install all plugins
    echo "Installing plugins. This may take a while."
    nvim --headless +PlugInstall +UpdateRemotePlugins +qa
    echo
    echo "Done."
fi

