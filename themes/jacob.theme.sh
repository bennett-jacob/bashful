git_status

git_ps1 = ""
git_ps1+="\[$text_purple$git_branch$text_reset\]"

PS1="\[$text_yellow\]\w\[$text_reset\] "
PS1+="$git_ps1"
PS1+="\n"
PS1+="\[$text_white\]\u@\h \A\[$text_reset\] \$ "

export PS1
