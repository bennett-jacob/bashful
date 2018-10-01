function git_ps1 {
    git_status

    if [ "$is_git_dir" = true ]; then
        printf "$text_purple $git_branch_symbol $git_branch$text_reset"

        if [ $git_updated -gt 0 ]; then
            printf "$text_green $git_updated_symbol $git_updated$text_reset"
        fi

        if [ $git_added -gt 0 ]; then
            printf "$text_green $git_added_symbol $git_added$text_reset"
        fi

        if [ $git_untracked -gt 0 ]; then
            printf "$text_red $git_untracked_symbol $git_untracked$text_reset"
        fi
    fi
}

PS1="\[$text_yellow\]\w\[$text_reset\] \$(git_ps1)\n"
PS1+="\[$text_white\]\u@\h \A\[$text_reset\] \$ "

export PS1
