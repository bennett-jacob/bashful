####################
# Git
function git_status {
    is_git_dir=false

    git_branch_symbol="✪"
    git_updated_symbol="⌦"
    git_added_symbol="⚠︎"
    git_deleted_symbol=""
    git_untracked_symbol="⚠︎"
    git_staged_symbol="●"

    if [[ -d .git ]]; then
        is_git_dir=true

        # https://codereview.stackexchange.com/a/117675/
        git_status=$(git status --porcelain -b)

        while read -r line; do
            case "$line" in
                "## No commits yet on "*)
                    git_branch=$(echo "$line" | grep -oE '[^ ]+$')
                    ;;
                "## "*)
                    # Get the local branch name
                    git_branch=$(echo "$line" | cut -d " " -f2 | cut -d. -f1)
                    # TODO: get commits ahead/behind
                    ;;
                @[:space:M]|[MM]|[M:space:]*)
                    git_updated=$((git_updated + 1))
                    ;;
                @[:space:A]|[AA]|[A:space:]*)
                    git_added=$((git_added + 1))
                    ;;
                @[DD]|[D:space:]*)
                    git_deleted=$((git_deleted + 1))
                    ;;
                @[:space:?]|[??]|[?:space:]*)
                    git_untracked=$((git_untracked + 1))
                    ;;
                # @[:space:D]*)
                #     git_renamed=$((git_renamed + 1))
                #     ;;
            esac
        done <<< "$git_status"
    fi
}
