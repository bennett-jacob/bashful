_plugin_help_text() {
    default_plugin_help_text = "Plugins are loaded in via .bashrc"
    if [ -z "$1" ] # is parameter #1 zero length?
    then
        # no parameter passed.
        echo "$default_plugin_help_text"
    else
        if [ -f $BASHFUL_DIR/plugins/$1/help ]; then
            # if help file exists, print it
            cat $BASHFUL_DIR/plugins/$1/help
        else
            # if no help file, print helpful line
            echo "$defult_plugin_help_text"
        fi
    fi
}

alias plugins="_plugin_help_text"
