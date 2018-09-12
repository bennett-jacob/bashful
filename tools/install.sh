source ../settings.sh

function check_git {
    git remote update
    git status -s
}


if git --version >/dev/null 2>&1 ; then
    check_git
else
    echo "Git not installed."
fi