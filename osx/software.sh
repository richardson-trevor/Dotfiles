#!/bin/bash

#shellcheck disable=SC1090
. ~/.files/setup/functions.sh

set -euo pipefail
IFS=$'\n\t'

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || exit 1

# Ask for the administrator password upfront
sudo -v

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    heading "Installing Homebrew"

    #Skip the "Press enter to continue…" prompt.
    true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

heading 'Brew bundle'
brew update
brew cleanup
env PATH=${PATH//$(pyenv root)\/shims:/} brew doctor || exit 1 # Make brew play nicely with pyenv
brew bundle --file=~/.files/osx/Brewfile
if [ -e ~/.files.extra/osx/Brewfile ]; then
   brew bundle --file=~/.files.extra/osx/Brewfile
fi
brew upgrade
brew cleanup

if [[ ! -d ~/.nvm ]]; then
    heading "Finishing nvm configuration"

    mkdir ~/.nvm
    cp "$(brew --prefix nvm)/nvm-exec" ~/.nvm/
    link_file "$(brew --prefix nvm)/nvm.sh" ~/.nvm/nvm.sh
fi
