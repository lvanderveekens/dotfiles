# my bashrc 

### ALIASES
alias b='mvn clean install'
alias tmux='tmux -2'

# COLORS
DEFAULT='\001\e[00m\002'
RED='\001\e[01;31m\002'
GREEN='\001\e[01;32m\002'
YELLOW='\001\e[01;33m\002'
UNDERLINED='\001\e[01;04m\002'

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
    } else {
        print $0
    }
    }' | less -R
}

function editlog() {
    svn propedit -r "$1" --revprop svn:log .
}

function diff() {
    svn diff "$@" | colordiff | awk '{gsub("\r",""); print}' | less -R
}

function get_branch() {
    branch=$(svn info 2> /dev/null | grep "Relative URL" | awk '{ sub("branches/",""); sub("\\^/","");  sub("/"," "); printf "%s", $3; }')
    print_with_color $branch 
}

function print_with_color() {
    if [[ -n $1 ]]; then
        changes=$(svn st | wc -l 2> /dev/null)
        # is there anything to commit?
        if [[ $changes > 0 ]]; then
            # paint the branch RED
            printf "%s(%s ~ %s)%s" $RED $1 $changes $DEFAULT;
        else 
            # otherwise GREEN
            printf "%s(%s)%s" $GREEN $1 $DEFAULT;
        fi
    fi
}

function get_revision() {
    revision=$(svn info 2> /dev/null | grep "Revision: " | awk '{ printf "r%s", $2; }')
    print_with_color $revision
}

# set PS1 variable
W='$(svn=$(get_revision); if [ -n "$svn" ]; then printf "$svn \w"; else printf "\w"; fi)'
PS1=$YELLOW'\u '$DEFAULT$W' ▶▶ '

export PROMPT_COMMAND="echo -ne '\e]12;#00AFFF\a'"
