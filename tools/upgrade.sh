autoupdate=true

if git pull --rebase --stat origin master ; then
    echo "You have updated."
else
    echo "Update failed."
fi
