# Declare these variables globally so they're only initialized once.
CHEAT_BASE_URL="https://cht.sh/"
cheatConfiguredClient=""

## This function determines which http get tool the system has installed and returns an error if there isnt one
cheatGetConfiguredClient()
{
    if command -v curl &>/dev/null; then
        cheatConfiguredClient="curl"
    elif command -v wget &>/dev/null; then
        cheatConfiguredClient="wget"
    elif command -v http &>/dev/null; then
        cheatConfiguredClient="httpie"
    elif command -v fetch &>/dev/null; then
        cheatConfiguredClient="fetch"
    else
        echo "Error: This tool reqires either curl, wget, httpie, or fetch to be installed." >&2
        return 1
    fi
}

## Allows to call the users configured client without if statements everywhere
cheatHttpGet()
{
    case "$cheatConfiguredClient" in
        curl)   curl -A curl -s "$@" ;;
        wget)   wget -qO- "$@" ;;
        httpie) http -b GET "$@" ;;
        fetch)  fetch -q "$@" ;;
    esac
}


checkInternet()
{
    cheatHttpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

usage()
{
    cat $BASHFUL_DIR/plugins/cheat/help
}

getCheatSheet()
{
    if [[ $# == 1 ]]; then
        if [[ $search == true ]]; then
            cheatRequestUrl="$CHEAT_BASE_URL~$1"
        else
            cheatRequestUrl="$CHEAT_BASE_URL$1"
        fi
    else
        cheatRequestUrl="$CHEAT_BASE_URL$1"
    fi

    # For some reason, 2 args are given in some OSs when only one arg was passed
    # through the command line. The first arg is often `ls`. So ignore the first
    # arg and just search the second.
    if [[ $# == 2 ]]; then
        if [[ $search == true ]]; then
            cheatRequestUrl="$CHEAT_BASE_URL~$2"
        else
            cheatRequestUrl="$CHEAT_BASE_URL$2"
        fi
    fi

    if [[ $insensitive != "" || $recursive != "" || $boundry != "" ]]; then cheatRequestUrl+=/$boundry$insensitive$recursive; fi ## add this to the end of the cheatRequestUrl as flags

    printf "$text_blue$cheatRequestUrl$text_reset\n"
    cheatHttpGet $cheatRequestUrl
}


### This function just wraps some of the special pages provided by cheat.sh
# checkSpecialPage()
# {
#     temp=$1
#     if [[ $1 == "list" ]]; then
#         temp=":list"
#     elif [[ $1 == "learn" ]]; then
#         temp=":list"
#     elif [[ $1 == "styles" ]]; then
#         temp=":styles"
#     fi
#     if [[ $2 == "1" ]]; then
#         arg1=$temp
#     else
#         arg2=$temp
#     fi
# }

cheat_plugin_main()
{
    search=false
    insensitive=""
    recursive=""
    boundry=""
    cheatRequestUrl=""

    cheatGetConfiguredClient || return

    arguments=()

    # https://stackoverflow.com/a/16655341
    local OPTIND o a
    while getopts "s" o; do
        case "${o}" in
            s)
                search=true
                ;;
            *)
                # echo "No options"
                ;;
        esac
    done
    shift $((OPTIND-1))

    # while getopts "hs" opt; do
    #     printf "$text_red$opt$text_reset\n"
    #     case "${opt}" in
    #         \?) echo "Invalid option: -$OPTARG" >&2
    #                 # exit 1
    #                 ;;
    #         h)    usage
    #                 # exit 0
    #                 ;;
    #         s)    search="1"
    #                 ;;
    #         :)    echo "Option -$OPTARG requires an argument." >&2
    #                 # exit 1
    #                 ;;
    #     esac
    # done

    ### This functions sets arg 1 and arg 2 to be unqique items after the options
    # for arg; do
    #     if [[ $arg != "-r" && $arg != "-s" && $arg != "-b" && $arg != "-i" ]]; then
    #         if [ -z ${arg1+x} ]; then
    #             arg1=$arg
    #         fi
    #         if [ ! -z ${arg1+x} ]; then
    #             arg2=$arg
    #         fi
    #     fi
    # done

    ## check for special pages before moving on
    # checkSpecialPage $arg1 1
    # checkSpecialPage $arg2 2

    if [[ $# == 0 ]]; then
        usage
        # exit 0
    elif [[ $1 == "help" || $1 == ":help" ]]; then ## shows the help and prevents the user from seeing cheat.sh/:help
        usage
        # exit 0
    else
        checkInternet || return

        arguments+=( "$1" )

        if [[ $arg1 != $arg2 ]]; then ## if they equal each other that means there was no arg 2 supplied
            arguments+= "$2"
            getCheatSheet ${arguments[0]} ${arguments[1]}
            # exit 0
        else
            getCheatSheet ${arguments[0]}
            # exit 0
        fi
        # exit 0
    fi
}

alias cheat="cheat_plugin_main"
