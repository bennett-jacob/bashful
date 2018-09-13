function update {
    # Use colors, but only if connected to a terminal, and that terminal
    # supports them.
    if which tput >/dev/null 2>&1; then
        ncolors=$(tput colors)
    fi
    if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
        RED="$(tput setaf 1)"
        GREEN="$(tput setaf 2)"
        YELLOW="$(tput setaf 3)"
        BLUE="$(tput setaf 4)"
        BOLD="$(tput bold)"
        NORMAL="$(tput sgr0)"
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        NORMAL=""
    fi

    # Only enable exit-on-error after the non-critical colorization stuff,
    # which may fail on systems lacking tput or terminfo
    # set -e

    command -v git >/dev/null 2>&1 || {
        printf "${RED}Error:${NORMAL} git is not installed\n"
        return 1
    }

    command git -C "$BASHFUL_DIR" fetch origin master >/dev/null 2>&1 || {
        printf "${RED}Error:${NORMAL} bashful could not update remote refs\n"
        return 1
    }

    command git -C "$BASHFUL_DIR" reset --hard origin/master >/dev/null 2>&1 || {
        printf "${RED}Error:${NORMAL} bashful update failed during git pull\n"
        return 1
    }

    printf "${GREEN}Bashful is up to date!\n"
}

update
