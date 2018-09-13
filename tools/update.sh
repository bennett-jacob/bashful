function check_git {
    # Update remote refs
    if git remote update >/dev/null 2>&1 ; then
        :
    else
        # Error updating remote refs
        exit 1
    fi
}

function main {
    if git --version >/dev/null 2>&1 ; then
        # If check_git has results, ask to update
        if [ -z "$(check_git)" ]; then
            # No results, do nothing.
            :
        else
            if git pull --rebase --stat origin master ; then
                echo "You have updated."
            else
                echo "Update failed."
            fi
        fi
    else
        echo "Git not installed."
    fi
}

main
