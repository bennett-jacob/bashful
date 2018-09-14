####################
# Git
function git_info {
    if [[ -d .git ]]; then
        # Based on: http://stackoverflow.com/a/13003854/170413
        local branch_name
        if branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
            if [[ "$branch_name" == "HEAD" ]]; then
                branch_name='detached*'
            fi
            printf "$text_purple ✪ $branch_name$text_reset"
        fi

        local left_right=$(git rev-list --left-right --count master...origin/master)
        local num_behind=$(echo $left_right | grep -oE '^[0-9]+')
        local num_ahead=$(echo $left_right | grep -Eo '[0-9]+$')

        if [[ $num_ahead -gt 0 ]]; then printf " ↑$num_ahead"; fi
        if [[ $num_behind -gt 0 ]]; then printf " ↓$num_behind"; fi

        local num_untracked=$(git status --porcelain 2>/dev/null | grep "^??" | wc -l)
        if [[ $num_untracked -gt 0 ]]; then
            clean_num_untracked=$(echo $num_untracked | grep -o '[0-9]*')
            printf "$text_red ⚠︎ $clean_num_untracked$text_reset"
        fi

        local num_dirty=$(git status --porcelain 2>/dev/null| grep "^ M" | wc -l)
        if [[ $num_dirty -gt 0 ]]; then
            clean_num_dirty=$(echo $num_dirty | grep -o '[0-9]*')
            printf "$text_green ⌦ $clean_num_dirty$text_reset"
        fi

        local num_cached=$(git diff --cached --numstat | wc -l)
        if [[ $num_cached -gt 0 ]]; then
            clean_num_cached=$(echo $num_cached | grep -o '[0-9]*')
            printf "$text_yellow ● $clean_num_cached$text_reset"
        fi
    fi
}
function find_git_branch {
    if [[ -d .git ]]; then
        # Based on: http://stackoverflow.com/a/13003854/170413
        local branch
        if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
            if [[ "$branch" == "HEAD" ]]; then
                branch='detached*'
            fi
            printf "$text_purple ✪ $branch$text_reset"
        fi
    fi
}

function find_git_untracked {
    if [[ -d .git ]]; then
        local num_untracked=$(git status --porcelain 2>/dev/null | grep "^??" | wc -l)
        if [[ $num_untracked -gt 0 ]]; then
            clean_num_untracked=$(echo $num_untracked | grep -o '[0-9]*')
            printf "$text_red ⚠︎ $clean_num_untracked$text_reset"
        fi
    fi
}

function find_git_dirty {
    if [[ -d .git ]]; then
        local num_dirty=$(git status --porcelain 2>/dev/null| grep "^ M" | wc -l)
        if [[ $num_dirty -gt 0 ]]; then
            clean_num_dirty=$(echo $num_dirty | grep -o '[0-9]*')
            printf "$text_green ⌦ $clean_num_dirty$text_reset"
        fi
    fi
}

function find_git_cached {
    if [[ -d .git ]]; then
        local num_cached=$(git diff --cached --numstat | wc -l)
        if [[ $num_cached -gt 0 ]]; then
            clean_num_cached=$(echo $num_cached | grep -o '[0-9]*')
            printf "$text_yellow ● $clean_num_cached$text_reset"
        fi
    fi
}

function find_behind_ahead {
    if [[ -d .git ]]; then
        local left_right=$(git rev-list --left-right --count master...origin/master)
        local num_behind=$(echo $left_right | grep -oE '^[0-9]+')
        local num_ahead=$(echo $left_right | grep -Eo '[0-9]+$')

        if [[ $num_ahead -gt 0 ]]; then printf " ↑$num_ahead"; fi
        if [[ $num_behind -gt 0 ]]; then printf " ↓$num_behind"; fi
    fi
}
