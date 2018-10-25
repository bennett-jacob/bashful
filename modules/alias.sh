#!/bin/bash

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='osx'
fi
#------------------------------------------------
## FILES

if [[ "$platform" == 'osx' ]]; then

    # Mac shortcuts
    alias l="ls -lahG"
    alias ls="ls -G"
    alias ll="ls -lahG"
    alias la="ls -aG"
    alias lm="ls -mG"
    alias lsd="ls -alFG | grep /$"

elif [[ "$platform" == 'linux' ]]; then
    # Colorize diff output (depends on colordiff)
    # sudo apt-get install colordiff
    alias diff="colordiff"

    alias l="ls -lah --color=auto"
    alias ll="ls -lah --color=auto"
    alias la="ls -a --color=auto"
    alias lm="ls -m --color=auto"
    alias lsd="ls -alF | grep /$"

    # (almost) never fail mkdir
    alias mkdir="mkdir -pv"

    # Do not delete / prompt if deleting more than 3 files at a time
    #alias rm="rm -I --preserve-root"

    # Ask confirmation
    alias mv="mv -i"
    alias cp="cp -i"
    alias ln="ln -i"
fi

#------------------------------------------------
## GENERAL

alias c="clear"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias in="sudo apt install"
alias upd="sudo apt-get update && sudo apt-get upgrade"

# Resume wget by default (saves a lot of pain)
alias wget="wget -c"

# This alias is necessary to access the user's aliases when using sudo
alias sudo="sudo "

## NAVIGATION
alias ..="cd .."

alias sourceme="source ~/.bash_profile"

# Show the size (sorted) of the folders in this directory
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
