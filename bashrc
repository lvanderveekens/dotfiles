# my bashrc containing aliases and environment variables

### ALIASES
alias b='mvn clean install'
alias startw='VBoxManage startvm Windows7 --type headless'

### ENVIRONMENT
WORK="$HOME/code/amm/trunk"

# ANSI color codes
GREEN='\e[01;32m'
DEFAULT='\e[00m'
ORANGE='\e[38;5;202m'
export BOLD='\e[1;1m'
export NO_COLOR='\e[00m'

if ps $PPID | grep mc; then
    PS1='[mc] \u@\h:\w $ '
elif [ "$color_prompt" = yes ]; then

    DIR='$(if [ -n "$(get_branch_and_dir)" ]; then echo -e "$(get_branch_and_dir)"; else echo -e "$DEFAULT\w"; fi)'
    PS1=$ORANGE'┌'$GREEN' \u '$DEFAULT$DIR'\n'$ORANGE'└'$DEFAULT' '
else 
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w $ '
fi

### FUNCTIONS
log() {
    svn log "$@" | awk '{sub("luciano","\033[01;32mluciano\033[00m"); print}' | less -R
}
logedit() {
    svn propedit "$@" --revprop svn:log .
}
blame() {
    svn blame "$@" | less
}
diff() {
    svn diff "$@" | colordiff | awk '{gsub("\r",""); print}' | less -R
}
add() {
    files=$(svn st | grep ? | awk '{ print $2; }')
    svn add $files
}

get_branch_and_dir() {
    svn info 2> /dev/null | grep "Relative URL" | 
    awk '{ sub("branches/",""); 
           sub("\\^/",""); 
           sub("/"," "); 
           sub("/"," "); 
           printf "%s[%s]%s %s(⎇  %s) %s", ENVIRON["BOLD"] ,$3, ENVIRON["NO_COLOR"], ENVIRON["BOLD"], $4, ENVIRON["NO_COLOR"];
           for (i=5; i<=NF;i++) { 
               if (i==5) {
                   printf "/"$i
               } else {
                   printf " "$i" "
               }
           } 
       }'
}
