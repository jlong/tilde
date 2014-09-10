#!/bin/bash

SCRIPT=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/`basename "${BASH_SOURCE[0]}"`
SCRIPTPATH=`dirname $SCRIPT`

#######################
echo "Lib"
#######################

mkdir $HOME/lib
ln -sfv $SCRIPTPATH/lib/rake-complete.rb $HOME/lib/rake-complete.rb

echo ""


#######################
echo "ACK"
#######################

ln -sfv $SCRIPTPATH/.ackrc $HOME/.ackrc

echo ""


#######################
echo "GIT"
#######################

# A couple of things for Git that we want to be user global. Note that we
# should NOT link .git and .gitmodules as these belong to this project and are
# not intended to be in my user directory.
ln -sfv $SCRIPTPATH/.gitconfig $HOME/.gitconfig
ln -sfv $SCRIPTPATH/.gitignore $HOME/.gitignore
ln -sfv $SCRIPTPATH/.gitusers $HOME/.gitusers

echo ""


#######################
echo "VIM"
#######################
ln -sv $SCRIPTPATH/vim/ $HOME/.vim
ln -sfv $SCRIPTPATH/.vimrc $HOME/.vimrc
ln -sfv $SCRIPTPATH/.gvimrc $HOME/.gvimrc
mkdir $SCRIPTPATH/.vim-tmp

# Pull in our .vim/bundles
git submodule update --init

# Install plugins
vim +PluginInstall +qall

echo ""


#######################
echo "Screen"
#######################

ln -sfv $SCRIPTPATH/.screenrc $HOME/.screenrc

echo ""

#######################
echo "IRB"
#######################

ln -sfv $SCRIPTPATH/.irbrc $HOME/.irbrc

echo ""

#######################
echo "JSHint"
#######################

npm install -g jshint
ln -sfv $SCRIPTPATH/.jshintrc $HOME/.jshintrc

echo ""


#######################
echo "Bash Profile"
#######################

ln -sfv $SCRIPTPATH/.exports $HOME/.exports
ln -sfv $SCRIPTPATH/.aliases $HOME/.aliases
ln -sfv $SCRIPTPATH/.projects $HOME/.projects
ln -sfv $SCRIPTPATH/.git-completion $HOME/.git-completion

echo ""
echo "Files linked. Add the following lines to your .bash_profile:"
echo ""
echo "  source ~/.exports"
echo "  source ~/.aliases"
echo "  source ~/.git-completion"
echo "  source ~/.projects"
echo "  complete -C path/to/tilde/lib/rake-complete.rb -o default rake"
echo ""
