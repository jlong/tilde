#!/bin/bash

#######################
echo "Lib"
#######################

ln -sv $PWD/lib/ $HOME/lib

echo ""


#######################
echo "ACK"
#######################

ln -sfv $PWD/.ackrc $HOME/.ackrc

echo ""


#######################
echo "GIT"
#######################

# A couple of things for Git that we want to be user global. Note that we
# should NOT link .git and .gitmodules as these belong to this project and are
# not intended to be in my user directory.
ln -sfv $PWD/.gitconfig $HOME/.gitconfig
ln -sfv $PWD/.gitignore $HOME/.gitignore
ln -sfv $PWD/.gitusers $HOME/.gitusers

echo ""


#######################
echo "VIM"
#######################
ln -sv $PWD/vim/ $HOME/.vim
ln -sfv $PWD/.vimrc $HOME/.vimrc
ln -sfv $PWD/.gvimrc $HOME/.gvimrc
mkdir $PWD/.vim-tmp

# Pull in our .vim/bundles
git submodule update --init

echo ""


#######################
echo "IRB"
#######################

ln -sfv $PWD/.irbrc $HOME/.irbrc

echo ""

#######################
echo "JSHint"
#######################

npm install -g jshint
ln -sfv $PWD/.jshintrc $HOME/.jshintrc

echo ""


#######################
echo "Bash Profile"
#######################

ln -sfv $PWD/.aliases $HOME/.aliases
ln -sfv $PWD/.projects $HOME/.projects
ln -sfv $PWD/.git-completion $HOME/.git-completion

echo ""
echo "Files linked. Add the following lines to your .bash_profile:"
echo ""
echo "  source ~/.aliases"
echo "  source ~/.git-completion"
echo "  source ~/.projects"
echo "  complete -C path/to/tilde/lib/rake-complete.rb -o default rake"
echo ""
