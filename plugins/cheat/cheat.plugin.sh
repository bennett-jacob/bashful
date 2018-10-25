CHEAT_BASE_URL="https://cht.sh/"

configuredClient=""
## rest of these variables are search flags
search="0"
insensitive=""
recursive=""
boundry=""
link=""

## This function determines which http get tool the system has installed and returns an error if there isnt one
getConfiguredClient()
{
    if command -v curl &>/dev/null; then
        configuredClient="curl"
    elif command -v wget &>/dev/null; then
        configuredClient="wget"
    elif command -v http &>/dev/null; then
        configuredClient="httpie"
    elif command -v fetch &>/dev/null; then
        configuredClient="fetch"
    else
        echo "Error: This tool reqires either curl, wget, httpie, or fetch to be installed." >&2
        return 1
    fi
}

## Allows to call the users configured client without if statements everywhere
httpGet()
{
    case "$configuredClient" in
        curl)   curl -A curl -s "$@" ;;
        wget)   wget -qO- "$@" ;;
        httpie) http -b GET "$@" ;;
        fetch)  fetch -q "$@" ;;
    esac
}


checkInternet()
{
    httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

usage()
{
cat <<EOF
Cheat
Description: Cheatsheets for quick information about multiple programming languages along with terminal commands
Usage: cheat [flags] [command] or cheat [flags] [programming language] [subject]
    -s    Does a search for last argument rather than looking for exact match
    -i    Case insensitive search
    -b    Word boundaries in search
    -r    Recursive search
    -u    Update Bash-Snippet Tools
    -h    Show the help
    -v    Get the tool version
Special Pages:
    hello            Describes building the hello world program written in the language
    list             This lists all cheatsheets related to previous arg if none it lists all cheatsheets
    learn            Shows a learn-x-in-minutes language cheat sheet perfect for getting started with the language
    1line            A collection of one-liners in this language
    weirdness    A collection of examples of weird things in this language
Examples:
    cheat rust hello
    cheat -r -b -i go
    cheat julia Functions
    cheat -i go operators
EOF
}

getCheatSheet()
{
    if [[ $# == 1 ]]; then
        if [[ $search == "1" ]]; then
            link="$CHEAT_BASE_URL~$1"
        else
            link="$CHEAT_BASE_URL$1"
        fi
    else
        link="$CHEAT_BASE_URL$1"
    fi

    # For some reason, 2 args are given in some OSs when only one arg was passed
    # through the command line. The first arg is often `ls`. So ignore the first
    # arg and just search the second.
    if [[ $# == 2 ]]; then
        if [[ $search == "1" ]]; then
            link="$CHEAT_BASE_URL~$2"
        else
            link="$CHEAT_BASE_URL$2"
        fi
    fi

    if [[ $insensitive != "" || $recursive != "" || $boundry != "" ]]; then link+=/$boundry$insensitive$recursive; fi ## add this to the end of the link as flags

    printf "$text_blue$link$text_reset\n"
    httpGet $link
}


### This function just wraps some of the special pages provided by cheat.sh
checkSpecialPage()
{
    temp=$1
    if [[ $1 == "list" ]]; then
        temp=":list"
    elif [[ $1 == "learn" ]]; then
        temp=":list"
    elif [[ $1 == "styles" ]]; then
        temp=":styles"
    fi
    if [[ $2 == "1" ]]; then
        arg1=$temp
    else
        arg2=$temp
    fi
}

cheat_plugin_main()
{
    getConfiguredClient || return

    while getopts "ribuvhis" opt; do
        case "$opt" in
            \?) echo "Invalid option: -$OPTARG" >&2
                    # exit 1
                    ;;
            h)    usage
                    # exit 0
                    ;;
            s)    search="1"
                    ;;
            :)    echo "Option -$OPTARG requires an argument." >&2
                    # exit 1
                    ;;
        esac
    done

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
        checkInternet || exit 1
        if [[ $arg1 != $arg2 ]]; then ## if they equal each other that means there was no arg 2 supplied
            getCheatSheet $arg1 $arg2
            # exit 0
        else
            getCheatSheet $arg1
            # exit 0
        fi
        # exit 0
    fi
}

alias cheat="cheat_plugin_main"
