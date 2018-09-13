function backup_old_bashrc {
    if [ -f ~/.bashrc ]; then
        mv ~/.bashrc ~/.bashrc.bak
    fi
}

function backup_old_bash_profile {
    if [ -f ~/.bash_profile ]; then
        mv ~/.bash_profile ~/.bash_profile.bak
    fi
}
