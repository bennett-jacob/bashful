PS1="\[$text_yellow\]\w\[$text_reset\] \$(find_git_branch)\$(find_git_untracked)\$(find_git_dirty)\$(find_git_cached)\n"
PS1+="\[$text_white\]\u@\h \A\[$text_reset\] \$ "

export PS1
