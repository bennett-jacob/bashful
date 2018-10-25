# Aliases

#-------------------------------------------------
# General
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gac="git add . && git commit -m"
alias gp="git push"
alias gpl="git pull && git submodule foreach git pull origin master"
alias gck="git checkout"

#-------------------------------------------------
# Logging
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glogd="git log --pretty=format:'%Cgreen(%cd)%Creset %C(bold blue)%an%Creset - %s'"
alias glogc="git log --pretty=format:'- %s'"
