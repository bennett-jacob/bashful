CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

BASHFUL_DIR=${BASHFUL_DIR:="$HOME/.bashful"}

# Run the install process.
source $BASHFUL_DIR/tools/install.sh
