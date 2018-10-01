

PS1="\[$text_yellow\]\w\[$text_reset\] \$($text_purple$git_branch$text_red ⚠︎ $git_untracked)\n"
PS1+="\[$text_white\]\u@\h \A\[$text_reset\] \$ "

export PS1
