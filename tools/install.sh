while getopts irh opt ; do
    case $opt in
        i)
            echo "INTERACTIVE"
            ;;
        r)
            echo "RADIOACTIVE"
            ;;
        h)
            echo ""
            echo "BASHFUL INSTALLER"
            echo ""
            echo "Usage:"
            echo "  -i     Interactive installation"
            echo "  -r     Radioactive installation"
            echo ""
            ;;
    esac
done

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
set -e

if ! command bash --version >/dev/null 2>&1; then
    printf "${RED}Bash is not installed!${NORMAL} Please install bash first!\n"
    exit 1
fi

if [ ! -n "$BASHFUL_DIR" ]; then
    BASHFUL_DIR=~/.bashful
fi

if [ -d "$BASHFUL_DIR" ]; then
    printf "${RED}You already have Bashful installed.${NORMAL}\n"
    printf "You'll need to remove ${YELLOW}$BASHFUL_DIR${NORMAL} if you want to re-install.\n"
    exit 1
fi

printf "${BLUE}Cloning Bashful...${NORMAL}\n"
command -v git >/dev/null 2>&1 || {
    printf "${RED}Error:${NORMAL} git is not installed\n"
    exit 1
}
env git clone --depth=1 https://github.com/jacobkdick/bashful.git "$BASHFUL_DIR" || {
    printf "${RED}Error:${NORMAL} git clone of bashful repo failed\n"
    exit 1
}

printf "${BLUE}Looking for an existing bash config...${NORMAL}\n"
if [ -f ~/.bashrc ] || [ -h ~/.bashrc ]; then
    printf "${YELLOW}Found ~/.bashrc.${NORMAL} ${GREEN}Backing up to ~/.bashrc.pre-bashful${NORMAL}\n";
    mv ~/.bashrc ~/.bashrc.pre-bashful;
fi
if [ -f ~/.bash_profile ] || [ -h ~/.bash_profile ]; then
    printf "${YELLOW}Found ~/.bash_profile.${NORMAL} ${GREEN}Backing up to ~/.bash_profile.pre-bashful${NORMAL}\n";
    mv ~/.bash_profile ~/.bash_profile.pre-bashful;
fi

printf "${BLUE}Using the Bashful template file and adding it to bash config${NORMAL}\n"
cp "$BASHFUL_DIR"/templates/.bashrc ~/.bashrc
cp "$BASHFUL_DIR"/templates/.bash_profile ~/.bash_profile

printf "${GREEN}"
echo '    __               __    ____      __'
echo '   / /_  ____ ______/ /_  / __/_  __/ /'
echo '  / __ \/ __ `/ ___/ __ \/ /_/ / / / / '
echo ' / /_/ / /_/ (__  ) / / / __/ /_/ / /  '
echo '/_.___/\__,_/____/_/ /_/_/  \__,_/_/   '
echo '                                       ....is now installed!'
echo ''
echo ''
echo 'Please look over the ~/.bashrc file to select themes and options.'
printf "${NORMAL}"
echo ''
echo ''
printf "You may now execute ${YELLOW}source $HOME/.bash_profile${NORMAL}"
echo ''
echo ''
