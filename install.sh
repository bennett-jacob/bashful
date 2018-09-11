#!/bin/bash

# Colors
source .bash_includes/colors.sh

CWD=$(pwd)

copy_to_home () {
    cp -R $1 ~/
    if [ -e ~/$1 ]; then
        echo -en "$1 copied to /home/$USER/$1\n"
    else
        echo -en "$bldred >> ERROR!$txtrst Did not copy $1\n"
    fi
}

if ! [[ $EUID -ne 0 ]]; then
    echo -en "$bldred >> ERROR!$txtrst Try running this installation as a regular user, not as root\n" 
    exit 1
fi

copy_to_home .bash_profile
copy_to_home .bashrc
copy_to_home .bash_includes

if [ -e ~/.bash_includes/prompt.sh ]; then
    echo -en "$txtgrn >> Installation successful.$txtrst\n"
    echo -en "You may now execute$txtylw source ~/.bash_profile$txtrst\n"
else
    echo -en "$txtred >> ERROR: Installation failed.$txtrst\n"
fi
