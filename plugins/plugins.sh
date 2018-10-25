_plugin_help_text() {
    DEFAULT_PLUGIN_HELP_TEXT="Plugins are loaded in via .bashrc"

    printf "$text_yellow"
    printf "BASHFUL PLUGIN$text_reset\n"

    if [ -z "$1" ] # is parameter #1 zero length?
    then
        # no parameter passed.
        echo $DEFAULT_PLUGIN_HELP_TEXT
    else
        if [ -f $BASHFUL_DIR/plugins/$1/help ]; then
            # if help file exists, print it
            cat $BASHFUL_DIR/plugins/$1/help
        else
            # if no help file, print helpful line
            echo $DEFAULT_PLUGIN_HELP_TEXT
        fi
    fi
}

alias plugins="_plugin_help_text"
