function verify_bashful_installation {
    ERROR=false

    if [[ ! -f $HOME/.bashrc ]]; then
        echo "bashful: $HOME/.bashrc doesn't exist."
        ERROR=true
    elif [[ $(diff $HOME/.bashrc $BASHFUL_TARGET_DIR/.bashrc) >/dev/null ]]; then
        echo "bashful: $HOME/.bashrc doesn't match bashful's."
        ERROR=true
    fi

    if [[ ! -f $HOME/.bash_profile ]]; then
        echo "bashful: $HOME/.bash_profile doesn't exist."
        ERROR=true
    elif [[ $(diff $HOME/.bash_profile $BASHFUL_TARGET_DIR/.bash_profile) >/dev/null ]]; then
        echo "bashful: $HOME/.bash_profile doesn't match bashful's."
    fi

    if [[ $(diff -rq $BASHFUL_DIR $BASHFUL_TARGET_DIR) >/dev/null ]]; then
        echo "bashful: $BASHFUL_DIR doesn't match $BASHFUL_TARGET_DIR"
        ERROR=true
    fi

    if $ERROR;
    then
        return 1
    fi

    return 0
}
