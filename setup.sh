#!/bin/bash

SCRIPT=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/`basename "${BASH_SOURCE[0]}"`
SCRIPTPATH=`dirname $SCRIPT`
PROFILE=$HOME/.bashrc

HELP="
Usage:
  $0 all        # Install all the things
  $0 all -tmux  # Everything but Tmux
  $0 +tmux      # Just install Tmux

Description:
  Wire in everything needed for my home directory. If parameters are
  included, only wire in specific sections.

Options:
  --profile path, -p path
    The profile file to append to. (Default: $PROFILE)

Components:
  Specific components can be turned on or off with a +/- prefix.

  vim      Vim config and plugins
  git      Git config
  screen   Screen config
  tmux     Tmux and Tmuxinator config
  ack      Ack config
  irb      IRB completion and other goodies
  rake     Rake completion
  jshint   JSHint config
  bash     Bash extras

"
case $# in 0) echo "$HELP"; exit 0;; esac

# Parse options
while true
do
  case $# in 0) break;; esac
  case $1 in
    --profile|-p)
      shift;
      PROFILE=$1
      ;;

    all)
      vim=true;
      git=true;
      screen=true;
      tmux=true;
      ack=true;
      irb=true;
      rake=true;
      jshint=true;
      bash=true;
      ;;

    +vim) vim=true;;
    -vim) vim=false;;

    +git) git=true;;
    -git) git=false;;

    +screen) screen=true;;
    -screen) screen=false;;

    +tmux) tmux=true;;
    -tmux) tmux=false;;

    +ack) ack=true;;
    -ack) ack=false;;

    +irb) irb=true;;
    -irb) irb=false;;

    +rake) rake=true;;
    -rake) rake=false;;

    +jshint) jshint=true;;
    -jshint) jshint=false;;

    +bash) bash=true;;
    -bash) bash=false;;

    help) echo "$HELP"; exit 0 ;;

    *) echo; echo "Invalid option $1."; echo "$HELP"; exit 2 ;;
  esac
  shift
done

if [ "$git" = true ]; then
  #######################
  echo "GIT"
  #######################

  update_profile=true

  # A couple of things for Git that we want to be user global. Note that we
  # should NOT link .git and .gitmodules as these belong to this project and are
  # not intended to be in my user directory.
  ln -sfv $SCRIPTPATH/.gitconfig $HOME/.gitconfig
  ln -sfv $SCRIPTPATH/.gitignore $HOME/.gitignore
  ln -sfv $SCRIPTPATH/.gitusers $HOME/.gitusers

  ln -sfv $SCRIPTPATH/.git-completion $HOME/.git-completion

  echo ""
fi

if [ "$vim" = true ]; then
  #######################
  echo "VIM"

  ln -sv $SCRIPTPATH/vim/ $HOME/.vim
  ln -sfv $SCRIPTPATH/.vimrc $HOME/.vimrc
  ln -sfv $SCRIPTPATH/.gvimrc $HOME/.gvimrc
  mkdir $SCRIPTPATH/.vim-tmp

  # Pull in our .vim/bundles
  cd $SCRIPTPATH
  git submodule update --init
  cd -

  # Install plugins
  vim +PluginInstall +qall

  echo ""
fi

if [ "$screen" = true ]; then
  #######################
  echo "Screen"
  #######################

  ln -sfv $SCRIPTPATH/.screenrc $HOME/.screenrc

  echo ""
fi

if [ "$tmux" = true ]; then
  #######################
  echo "tmux"
  #######################

  update_profile=true

  brew install reattach-to-user-namespace
  gem install tmuxinator

  ln -sfv $SCRIPTPATH/.tmux.conf $HOME/.tmux.conf
  ln -sv $SCRIPTPATH/tmuxinator $HOME/.tmuxinator

  ln -sfv $SCRIPTPATH/.tmux-completion $HOME/.tmux-completion
  ln -sfv $SCRIPTPATH/.tmuxinator-completion $HOME/.tmuxinator-completion

  echo ""
fi

if [ "$ack" = true ]; then
  #######################
  echo "ACK"
  #######################

  ln -sfv $SCRIPTPATH/.ackrc $HOME/.ackrc

  echo ""
fi

if [ "$irb" = true ]; then
  #######################
  echo "IRB"
  #######################

  ln -sfv $SCRIPTPATH/.irbrc $HOME/.irbrc

  echo ""
fi

if [ "$rake" = true ]; then
  #######################
  echo "Rake"
  #######################

  update_profile=true

  mkdir $HOME/lib
  ln -sfv $SCRIPTPATH/lib/rake-complete.rb $HOME/lib/rake-complete.rb

  echo ""
fi

if [ "$jshint" = true ]; then
  #######################
  echo "JSHint"
  #######################

  npm install -g jshint
  ln -sfv $SCRIPTPATH/.jshintrc $HOME/.jshintrc

  echo ""
fi

add_to_profile() {
  local line=$1
  touch $PROFILE
  if ! grep -q "$line" $PROFILE; then
    echo "  $line"
    eval $(echo "$line" | tee -a $PROFILE)
  fi
}

if [ "$bash" = true ]; then
  #######################
  echo "Bash Profile"
  #######################

  update_profile=true

  ln -sfv $SCRIPTPATH/.prompt $HOME/.prompt
  ln -sfv $SCRIPTPATH/.exports $HOME/.exports
  ln -sfv $SCRIPTPATH/.aliases $HOME/.aliases
  ln -sfv $SCRIPTPATH/.projects $HOME/.projects
fi

if [ "$update_profile" = true ]; then
  echo ""
  echo "Adding the following lines to your profile ($PROFILE):"
  echo ""

  if [ "$bash" = true ]; then
    add_to_profile 'source ~/.prompt'
    add_to_profile 'source ~/.exports'
    add_to_profile 'source ~/.aliases'
    add_to_profile 'source ~/.projects'
  fi

  if [ "$git" = true ]; then
    add_to_profile 'source ~/.git-completion'
  fi

  if [ "$tmux" = true ]; then
    add_to_profile 'source ~/.tmux-completion'
    add_to_profile 'source ~/.tmuxinator-completion'
  fi

  if [ "$rake" = true ]; then
    add_to_profile 'complete -C path/to/tilde/lib/rake-complete.rb -o default rake'
  fi
fi

echo ""
