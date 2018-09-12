source ../settings.sh

function check_git {
    if git remote update >/dev/null 2>&1 ; then
        continue
    else
        exit
    fi
    git status -s
}


if git --version >/dev/null 2>&1 ; then
    check_git
else
    echo "Git not installed."
fi