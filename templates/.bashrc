#!/bin/bash

####################
# Variables
BASHFUL_THEME=jacob

plugins=(
    git
)

# Only change BASHFUL_DIR if you installed bashful in a directory other than
# $HOME/.bashful
BASHFUL_DIR=${BASHFUL_DIR:="$HOME/.bashful"}

####################
# Aliases
# Add your custom aliases here.
# alias c="clear"

################################################################################
################################################################################
################################################################################
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

# Modules
source $BASHFUL_DIR/modules/_all.sh

# Plugins
for i in "${plugins[@]}"
do
    source $BASHFUL_DIR/plugins/$i/$i.plugin.sh
done

# Theme
source $BASHFUL_DIR/themes/_base.theme.sh
source $BASHFUL_DIR/themes/$BASHFUL_THEME.theme.sh
