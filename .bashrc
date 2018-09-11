#!/bin/bash

# Unique Bash version check
if ((BASH_VERSINFO[0] < 4))
then 
  echo "bash-better: Looks like you're running an older version of Bash." 
  echo "bash-better: You need at least bash-4.0 or some options will not work correctly." 
  echo "bash-better: Keep your software up-to-date!"
fi

source ~/.bash_includes/colors.sh
source ~/.bash_includes/settings.sh
source ~/.bash_includes/alias.sh
source ~/.bash_includes/prompt.sh

