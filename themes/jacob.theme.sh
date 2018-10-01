. $BASHFUL_DIR/themes/_base.theme.sh

function git_ps1 {
    git_status

    if [ $is_git_dir ]; then
        printf "$text_purple $git_branch_symbol $git_branch$text_reset"
    fi
}

PS1="\[$text_yellow\]\w\[$text_reset\] $(git_ps1)\n"
PS1+="\[$text_white\]\u@\h \A\[$text_reset\] \$ "

export PS1
