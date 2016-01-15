# my bashrc 

### ALIASES
alias b='mvn clean install'
alias tmux='tmux -2'
alias sshserver='ssh oracle@server'

# COLORS
DEFAULT='\001\e[00m\002'
RED='\001\e[01;31m\002'
GREEN='\001\e[01;32m\002'
YELLOW='\001\e[01;33m\002'

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

function editlog() {
    svn propedit -r "$1" --revprop svn:log .
}

function diff() {
    svn diff "$@" | colordiff | awk '{gsub("\r",""); print}' | less -R
}

function get_branch() {
    branch=$(svn info 2> /dev/null | grep "Relative URL" | awk '{ sub("branches/",""); sub("\\^/","");  sub("/"," "); printf "(%s)", $3; }')
    if [[ -n $branch ]]; then
    #    DEFAULT='\001\e[00m\002'
    #    RED='\001\e[01;31m\002'
    #    GREEN='\001\e[01;32m\002'
        # is there anything to commit?
        if [[ -n $(svn st 2> /dev/null) ]]; then
            # paint the branch RED
            printf '\001\033[01;31m\002'$branch'\001\033[00m\002';
        else 
            # otherwise GREEN
            printf $GREEN$branch$DEFAULT;
        fi
    fi
}

if [ "$color_prompt" = yes ]; then
    W='$(svn=$(get_branch); if [ -n "$svn" ]; then printf "$svn \w"; else printf "\w"; fi)'
    PS1=$YELLOW'\u '$DEFAULT$W' ▶ '
else 
    PS1='\u@\h:\w $ '
fi
