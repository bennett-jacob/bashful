#!/bin/bash

####################
# Variables
BASHFUL_THEME=jacob
BASHFUL_DIR=$HOME/.bashful # You shouldn't have to edit this one


####################
# Aliases
# Add your custom aliases here.
# alias c="clear"

####################
####################
####################
# DON'T EDIT BELOW THIS LINE
# Unique Bash version check
if ((BASH_VERSINFO[0] < 4))
then
  echo "bashful: Looks like you're running an older version of Bash."
  echo "bashful: You need at least bash-4.0 or some options will not work correctly."
  echo "bashful: Keep your software up-to-date!"
fi

# Check for updates
source $BASHFUL_DIR/tools/update.sh

source $BASHFUL_DIR/modules/_all.sh
source $BASHFUL_DIR/themes/_base.theme.sh
source $BASHFUL_DIR/themes/$BASHFUL_THEME.theme.sh
