CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [[ -f $CURRENT_DIR/settings.sh ]]; then
    source $CURRENT_DIR/settings.sh
else
    echo "bashful: The settings.sh file has moved."
    echo "bashful: Please put it back. Or open an issue."
    exit
fi

# Run the install process.
source $BASHFUL_DIR/tools/install.sh
