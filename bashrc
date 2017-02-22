# my bashrc 

###############
### ALIASES ###
###############

alias b='mvn clean install'
alias tmux='tmux -2'
alias sshserver='ssh -X oracle@NWS212'
alias ll='ls -l'
alias d='dirs -v |head -10'
alias p='pushd'
alias o='popd'

##############
### COLORS ###
##############

DEFAULT='\001\e[00m\002'
RED='\001\e[01;31m\002' 
GREEN='\001\e[01;32m\002'
GREEN_UNDERLINED='\001\e[01;32;04m\002'
YELLOW='\001\e[01;33m\002'
BLUE='\001\e[01;34m\002'
PINK='\001\e[01;35m\002'
UNDERLINED='\001\e[01;04m\002'

#################
### FUNCTIONS ###
#################

function log() 
{
    svn log "$@" | 
    awk '{ 
        if ($1 ~ /r[0-9]*/)  
            printf "%s%s%s\n", "\033[01;33m", $0, "\033[00m" 
        else if ($1 ~ /NTS-[0-9]*/) 
            printf "%s%s%s %s\n", "\033[38;5;210m", $1, "\033[00m", substr($0, index($0,$2))
        else 
            print $0
    }' | less -R
}

function get_branch() 
{
    branch=$(
        svn info 2> /dev/null | 
        grep "Relative URL" | 
        awk '{ 
            sub("branches/",""); 
            sub("\\^/","");  
            sub("/"," "); 
            if ($4 == "trunk")  
                printf "%s", toupper($3); 
            else 
                printf "%s(%s)", toupper($3), $4; 
        }'
    )
    echo $branch 
}

function print_svn() 
{
    if [[ -n $1 ]]; then
        changes=$(svn st | wc -l 2> /dev/null)
        # is there anything to commit?
        if [[ $changes > 0 ]]; then
            # paint the branch RED
            printf "%s" $RED;
        else 
            # otherwise GREEN
            printf "%s" $GREEN;
        fi
        # print the revision and set the color back to default
        printf "(%s→r%s)%s" $1 $2 $DEFAULT;
    fi
}

function get_revision() 
{
    revision=$(svn info 2> /dev/null | grep "Revision: " | awk '{ printf "%s", $2; }')
    print_svn $(get_branch) $revision 
}

#################
### VARIABLES ###
#################

# to fix search highlighting in tmux
export LESS_TERMCAP_mb=$'\E[01;31m'                # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'           # begin bold
export LESS_TERMCAP_me=$'\E[0m'                    # end mode
export LESS_TERMCAP_se=$'\E[0m'                    # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;016m\E[48;5;220m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                    # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m'          # begin underline

WORKSPACE='$(svn=$(get_revision); if [ -n "$svn" ]; then printf "\w$svn"; else printf "\w"; fi)'
PS1=$DEFAULT'\u@\h:'$WORKSPACE'$ '
