#!/bin/bash

find_git_branch() {
    # Based on: http://stackoverflow.com/a/13003854/170413
    local branch
    if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
        if [[ "$branch" == "HEAD" ]]; then
            branch='detached*'
        fi
        git_branch="$txtpur ✪ $branch$txtrst"
    else
        git_branch=""
    fi
}

#find_git_dirty() {
#    local status=$(git status --porcelain 2> /dev/null)
#    if [[ "$status" != "" ]]; then
#        #num_dirty=$(echo "$status" | wc -l)
#        num_dirty=$(wc -l <<< "$status")
#        git_dirty="$txtred$num_dirty*$txtrst"
#    else
#        git_dirty=""
#    fi
#}

# https://codedump.io/share/JUEEsHxuENuf/1/checking-for-a-dirty-index-or-untracked-files-with-git

find_git_untracked() {
    local num_untracked=$(git status --porcelain 2>/dev/null | grep "^??" | wc -l)
    if [[ $num_untracked -gt 0 ]]; then
        clean_num_untracked=$(echo $num_untracked | grep -o '[0-9]*')
        git_untracked="$txtred ⚠︎ $clean_num_untracked$txtrst"
    else
        git_untracked=""
    fi
}

find_git_dirty() {
    local num_dirty=$(git status --porcelain 2>/dev/null| grep "^ M" | wc -l)
    if [[ $num_dirty -gt 0 ]]; then
        clean_num_dirty=$(echo $num_dirty | grep -o '[0-9]*')
        git_dirty="$txtgrn ⌦ $clean_num_dirty$txtrst"
    else
        git_dirty=""
    fi
}

PROMPT_COMMAND="find_git_branch; find_git_untracked; find_git_dirty; $PROMPT_COMMAND"

PS1="\[$txtylw\]\w\[$txtrst\] \$git_branch\$git_untracked\$git_dirty\n"
PS1+="\[$txtwht\]\u@\h \A\[$txtrst\] \$ "

export PS1
