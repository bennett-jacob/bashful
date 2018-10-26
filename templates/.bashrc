#!/bin/bash

# Theme
BASHFUL_THEME=jacob

# Plugins
plugins=(
    git
)

# Aliases
# Add your custom aliases here.
# alias c="clear"

# Bashful settings
# Only change BASHFUL_DIR if you installed bashful in a directory other than
# $HOME/.bashful
BASHFUL_DIR=${BASHFUL_DIR:="$HOME/.bashful"}

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

# Check for updates (if not in development version)
DEVELOPMENT=false # set to true to avoid issues when working on Bashful
if [ "$DEVELOPMENT" != true ]; then
    source $BASHFUL_DIR/tools/update.sh
else
    printf "BASHFUL IN DEVELOPMENT, NOT CHECKING FOR UPDATES\n"
fi

# Modules
source $BASHFUL_DIR/modules/_all.sh

# Plugins
source $BASHFUL_DIR/plugins/plugins.sh
for p in ${plugins[@]}; do
    if [ -f $BASHFUL_DIR/plugins/$p/$p.plugin.sh ]; then
        source $BASHFUL_DIR/plugins/$p/$p.plugin.sh
    fi
done

# Theme
source $BASHFUL_DIR/themes/_base.theme.sh
source $BASHFUL_DIR/themes/$BASHFUL_THEME.theme.sh
