. $BASHFUL_DIR/themes/_base.theme.sh

PS1="\[$text_yellow\]\w\[$text_reset\] \$git_branch\$git_untracked\$git_dirty\n"
PS1+="\[$text_white\]\u@\h \A\[$text_reset\] \$ "

export PS1
