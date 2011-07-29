#!/bin/bash

ln -sv $PWD/lib/ $HOME/lib


#######################
#  ACK
#######################
ln -sfv $PWD/.ackrc $HOME/.ackrc


#######################
#  GIT
#######################

# A couple of things for Git that we want to be user global. Note that we
# should NOT link .git and .gitmodules as these belong to this project and are
# not intended to be in my user directory.
ln -sfv $PWD/.gitconfig $HOME/.gitconfig
ln -sfv $PWD/.gitignore $HOME/.gitignore
ln -sfv $PWD/.gitusers $HOME/.gitusers


#######################
#  VIM
#######################
ln -sv $PWD/.vim/ $HOME/.vim
ln -sfv $PWD/.vimrc $HOME/.vimrc
ln -sfv $PWD/.gvimrc $HOME/.gvimrc

# Pull in our .vim/bundles
git submodule update --init

#######################
#  IRB
#######################

ln -sfv $PWD/.irbrc $HOME/.irbrc


#######################
#  Bash Profile
#######################

ln -sfv $PWD/.aliases $HOME/.aliases
ln -sfv $PWD/.projects $HOME/.projects
ln -sfv $PWD/.git-completion $HOME/.git-completion
