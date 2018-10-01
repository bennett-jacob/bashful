export is_git_dir=false

export git_branch_symbol="✪"
export git_updated_symbol="⌦"
export git_added_symbol="⚠︎"
export git_deleted_symbol=""
export git_untracked_symbol=""
export git_staged_symbol="●"

git_branch=""
git_updated=0
git_added=0
git_deleted=0
git_untracked=0
git_ahead=0
git_behind=0
git_renamed=0

if [[ -d .git ]]; then
    export is_git_dir=true

    # https://codereview.stackexchange.com/a/117675/
    git status --porcelain -b | (
        # unset git_branch git_updated git_added git_deleted git_untracked git_ahead git_behind git_renamed
        while read line ; do
            case "$line" in
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
        done
    )
fi

export git_branch
export git_updated
export git_added
export git_deleted
export git_untracked
export git_ahead
export git_behind
export git_renamed
