#!/bin/bash

# Unique Bash version check
if ((BASH_VERSINFO[0] < 4))
then
  echo "bashful: Looks like you're running an older version of Bash."
  echo "bashful: You need at least bash-4.0 or some options will not work correctly."
  echo "bashful: Keep your software up-to-date!"
fi

# Check for updates
echo "Hello"

source ~/.bash_includes/config.sh
source ~/.bash_includes/colors.sh
source ~/.bash_includes/alias.sh
source ~/.bash_includes/prompt.sh

