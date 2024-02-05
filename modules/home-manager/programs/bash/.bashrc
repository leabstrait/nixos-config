#  ███████████    █████████    █████████  █████   █████
# ░░███░░░░░███  ███░░░░░███  ███░░░░░███░░███   ░░███
#  ░███    ░███ ░███    ░███ ░███    ░░░  ░███    ░███
#  ░██████████  ░███████████ ░░█████████  ░███████████
#  ░███░░░░░███ ░███░░░░░███  ░░░░░░░░███ ░███░░░░░███
#  ░███    ░███ ░███    ░███  ███    ░███ ░███    ░███
#  ███████████  █████   █████░░█████████  █████   █████
# ░░░░░░░░░░░  ░░░░░   ░░░░░  ░░░░░░░░░  ░░░░░   ░░░░░

#set -euo pipefail

### Source homegrown functions ###
# source $HOME/dotfiles/dotfiles.sh
source $HOME/notes/notes.sh

### fzf ###

# When selecting files with fzf, we show file content with syntax highlighting,
# or without highlighting if it's not a source file. If the file is a directory,
# we use tree to show the directory's contents.
# We only load the first 200 lines of the file which enables fast previews
# of large text files.
# Requires highlight and tree to be installed
export FZF_DEFAULT_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"


# Color man pages (with termcap variables)

man() {
    # Start blink
    LESS_TERMCAP_mb=$'\E[05;31m'    \
    # Start bold
    LESS_TERMCAP_md=$'\E[01;32m'    \
    # Turn off bold, blink and underline
    LESS_TERMCAP_me=$'\E[0m'        \
    # Stop standout
    LESS_TERMCAP_se=$'\E[0m'        \
    # Start standout (reverse video)
    LESS_TERMCAP_so=$'\E[01;44;30m' \
    # Stop underline
    LESS_TERMCAP_ue=$'\E[0m'        \
    # Start underline
    LESS_TERMCAP_us=$'\E[04;33m'    \
    command man "$@"
}


# History settings
HISTFILE=~/.bash_history
HISTSIZE=1000
SAVEHIST=500
HISTCONTROL=ignoreboth:erasedups


### Keybindings ###

# If there are multiple matches for completion, Tab should cycle through them
bind 'TAB:menu-complete'
# And Shift-Tab should cycle backwards
bind '"\e[Z": menu-complete-backward'

# Display a list of the matching files
bind "set show-all-if-ambiguous on"

# Perform partial (common) completion on the first Tab press, only start
# cycling full results on the second Tab press (from bash version 5)
bind "set menu-complete-display-prefix on"

# Cycle through history based on characters already typed on the line
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Keep Ctrl-Left and Ctrl-Right working when the above are used
bind '"\e[1;5C":forward-word'
bind '"\e[1;5D":backward-word'

### Other settings ###
WORDCHARS=${WORDCHARS//\/[&.;]/}            # Don't consider certain characters part of the word
PROMPT_EOL_MARK=''                          # Removes the trailing % at the end of newlines
export SUDO_PROMPT=$'\e[33mPassword:\e[0m ' # Make the sudo prompt simpler and colorful


# Funtions to load and unload env vars from an .env file
function loadenv() {
    [ "$#" -eq 1 ] && env="$1" || env="$PWD/.env"
    [ -f "$env" ] && { echo "Env file $(realpath $env) found - loading its env vars..."; } || { return 0; }
    set -o allexport
    source <(
        /usr/bin/cat "$env" |
            sed -e '/^#/d;/^\s*$/d' |
            sed -e "s/'/'\\\''/g" |
            sed -e "s/=\(.*\)/='\1'/g"
    ) && "$@"
    set +o allexport
    unset env
}
function unloadenv() {
    [ "$#" -eq 1 ] && oldenv="$1" || [ -f "$OLDPWD/.env" ] && oldenv="$OLDPWD/.env" || oldenv="$PWD/.env"
    [ -f "$oldenv" ] && { echo "Env file $(realpath $oldenv) found - remove its env vars..."; } || { return 0; }
    unset $(grep -v '^#' $oldenv | sed -E 's/(.*)=.*/\1/' | xargs)
    unset oldenv
}
# Run unloadenv(old dir) and loadenv(new dir) on every new directory
function cd() {
    builtin cd $@
    unloadenv
    loadenv
}
