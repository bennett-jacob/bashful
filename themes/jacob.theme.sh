. $BASHFUL_DIR/themes/_base.theme.sh

PS1="\[$text_yellow\]\w\[$text_reset\] \$(find_git_branch)\$(find_git_untracked)\$(find_git_dirty)\n"
PS1+="\[$text_white\]\u@\h \A\[$text_reset\] \$ "

export PS1
