# These settings are available from any file sourced by ./bashful.sh

export BASHFUL_AUTOUPDATE=true

# https://stackoverflow.com/a/246128
# Directory containing this file
export BASHFUL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

export BASHFUL_TARGET_DIR=$HOME/.bashful

# Colors
source $BASHFUL_DIR/modules/colors.sh
