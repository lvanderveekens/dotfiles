# my bashrc containing aliases and environment variables

### ALIASES
alias b='mvn clean install'
alias ncc="$HOME/code/amm/trunk/clients/ncc/application/runNccClient_luciano.sh"
alias tmux='tmux -2'
alias sshserver='ssh oracle@server'

### FUNCTIONS
function log() {
    svn log "$@" | 
    awk '{ 
    if ($1 ~ /r[0-9]{5}/)  {
        if ($3 ~ /luciano/) {
            printf "%s%s%s\n", "\033[38;5;208m", $0, "\033[00m" 
        } else {
        printf "%s%s%s\n", "\033[38;5;220m", $0, "\033[00m" 
        }
    } else if ($1 ~ /NTS-/) {
        print "    "$0
    } else
        print $0
    }' | less -R
}

function logedit() {
    svn propedit "$@" --revprop svn:log .
}

function blame() {
    svn blame "$@" | less
}

function diff() {
    svn diff "$@" | colordiff | awk '{gsub("\r",""); print}' | less -R
}

function add() {
    files=$(svn st | grep ? | awk '{ print $2; }')
    svn add $files
}

function get_branch() {
    branch=$(svn info 2> /dev/null | grep "Relative URL" | awk '{ sub("branches/",""); sub("\\^/","");  sub("/"," "); printf "(%s)", $3; }')
    if [[ -n $branch ]]; then
        # is there anything to commit?
        if [[ -n $(svn st 2> /dev/null) ]]; then
            # paint the branch RED
            echo $RED$branch$DEFAULT;
        else 
            # otherwise GREEN
            echo $GREEN$branch$DEFAULT;
        fi
    fi
}

# COLORS
RED='\e[01;31m'
YELLOW='\e[01;33m'
GREEN='\e[01;32m'
DEFAULT='\e[00m'
ORANGE='\e[38;5;202m'

if [ "$color_prompt" = yes ]; then
    W='$(svn=$(get_branch); if [ -n "$svn" ]; then echo -e "$svn \w"; else echo -e $DEFAULT"\w"; fi)'
    PS1=$YELLOW'\u '$W' ▶ '
else 
    PS1='\u@\h:\w $ '
fi
