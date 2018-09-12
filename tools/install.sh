source ../settings.sh

function check_git {
    if git remote update >/dev/null 2>&1 ; then
        # Update remote refs
        continue
    else
        # Error updating remote refs
        exit
    fi

    # Print git status
    git status -s
}


if git --version >/dev/null 2>&1 ; then
    # If check_git has results, ask to update
    if [ -z "$(check_git)" ]; then
        # No results, end.
        continue
    else
        echo "Need an update."
    fi

else
    echo "Git not installed."
fi