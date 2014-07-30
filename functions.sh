#!/bin/bash

. ~/.dotfiles/colors.sh

DOTFILES_ROOT="`pwd`"

info () {
     printf "  [ ${blue}..${reset} ] $1\n"
}

success () {
    printf "\r\033[2K  [ ${green}OK${reset} ] $1\n"
}

warn () {
    printf "\r\033[2K  [${orange}WARN${reset}] $1\n"
}

fail () {
    printf "\r\033[2K  [${red}FAIL${reset}] $1\n"
    exit
}

link_file () {
    ln -s $1 $2
    success "linked $1 to $2"
}

dotfile () {
    source=$1
    filename=`basename $source`
    dest="$HOME/$filename"

    if [ -h $dest ];then
	    success "link $dest already exists"
    elif [ -f $dest ] || [ -d $dest ]
    then
	    warn "$dest already exists"
    else
	    link_file $source $dest
    fi
}

link_dotfiles_directory() {
	#should check for existence of ~/.dotfiles
	#if not there, ask for path to clone the git repository to
	#and add a simlink at ~/.dotfiles
	if [ -h "$HOME/.dotfiles" ]
	then
		success ".dotfiles already linked"
	else
		link_file $DOTFILES_ROOT "$HOME/.dotfiles"
	fi
}

link_dotfiles() {
	DOTFILES_LINK="$HOME/.dotfiles/"

	for source in `find $DOTFILES_LINK -mindepth 2 -maxdepth 2 -name '\.*'`
	do
		dotfile ${source}
	done
}
