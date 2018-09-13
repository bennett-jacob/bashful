if [[ -f ./settings.sh ]]; then
    source ./settings.sh
else
    echo "bashful: The settings.sh file has moved."
    echo "bashful: Please put it back. Or open an issue."
    exit
fi

# Run the install process.
source $BASHFUL_DIR/tools/install.sh
