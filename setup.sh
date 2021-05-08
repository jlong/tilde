#!/bin/bash

SCRIPT=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/`basename "${BASH_SOURCE[0]}"`
SCRIPTPATH=`dirname $SCRIPT`
PROFILE=$HOME/.bashrc
OHMYZSH=$HOME/.oh-my-zsh
ZSHRC=$HOME/.zshrc

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
  brew     Homebrew
  screen   Screen config
  tmux     Tmux and Tmuxinator config
  ack      Ack config
  irb      IRB completion and other goodies
  rake     Rake completion
  jshint   JSHint config
  bash     Bash extras
  zsh      Zshell extras
  bin      Bin files

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
      brew=true;
      screen=true;
      tmux=true;
      ack=true;
      irb=true;
      rake=true;
      jshint=true;
      bash=true;
      bin=true;
      zsh=true;
      ;;

    +vim) vim=true;;
    -vim) vim=false;;

    +git) git=true;;
    -git) git=false;;

    +brew) brew=true;;
    -brew) brew=false;;

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

    +zsh) zsh=true;;
    -zsh) zsh=false;;

    +bin) bin=true;;
    -bin) bin=true;;

    help) echo "$HELP"; exit 0 ;;

    *) echo; echo "Invalid option $1."; echo "$HELP"; exit 2 ;;
  esac
  shift
done

if [ "$git" = true ]; then
  #######################
  echo "Git"
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

if [ "$brew" = true ]; then
  #######################
  echo "Homebrew"
  #######################

  if [[ ! -d /opt/homebrew/Cellar ]] && [[ ! -d /usr/local/Cellar ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
  fi

  echo ""
fi

if [ "$vim" = true ]; then
  #######################
  echo "Vim"

  ln -sv $SCRIPTPATH/.vim/ $HOME/.vim
  ln -sfv $SCRIPTPATH/.vimrc $HOME/.vimrc
  ln -sfv $SCRIPTPATH/.gvimrc $HOME/.gvimrc
  mkdir $SCRIPTPATH/.vim-tmp

  # Install plugins
  vim +PlugInstall +qall

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
  echo "Bash Extras"
  #######################

  update_profile=true

  ln -sfv $SCRIPTPATH/.prompt $HOME/.prompt
  ln -sfv $SCRIPTPATH/.exports $HOME/.exports
  ln -sfv $SCRIPTPATH/.aliases $HOME/.aliases
  ln -sfv $SCRIPTPATH/.projects $HOME/.projects
  ln -sfv $SCRIPTPATH/.brew-completion $HOME/.brew-completion
  
  echo ""
fi

add_to_zshrc() {
  local line=$1
  touch $ZSHRC
  if ! grep -q "$line" $ZSHRC; then
    echo "  $line"
    eval $(echo "$line" | tee -a $ZSHRC)
  fi
}

if [ "$zsh" = true ]; then
  #######################
  echo "Zshell Extras"
  #######################

  update_zshrc=true

  if [[ ! -d "$OHMYZSH" ]]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  echo ""
fi

if [ "$bin" = true ]; then
  #######################
  echo "Bin files"
  #######################

  ln -sfv $SCRIPTPATH/bin $HOME
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

  add_to_profile 'source ~/.brew-completion'
fi

if [ "$update_zshrc" = true ]; then
  echo ""
  echo "Adding the following lines to your zshrc ($ZSHRC):"
  echo ""

  if [ "$zsh" = true ]; then
    add_to_zshrc 'source ~/.aliases'
    add_to_zshrc 'source ~/.projects'
  fi
fi

echo ""
