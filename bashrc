# my bashrc containing aliases and environment variables

# ALIASES
alias b='mvn clean install'
alias startw='VBoxManage startvm Windows7 --type headless'

# ENVIRONMENT
WORK="$HOME/code/amm/trunk"

# load a couple of shell scripts
. $HOME/code/config/svn_branch.sh

if ps $PPID | grep mc; then
    PS1='[mc] \u@\h:\w $ '
elif [ "$color_prompt" = yes ]; then
    # ANSI color codes
    GREEN='\033[01;32m'
    DEFAULT='\033[00m'
    ORANGE='\033[38;5;202m'

    DIR='$(if [ -n "$(get_branch_and_dir)" ]; then echo -e "$(get_branch_and_dir)"; else echo -e "$DEFAULT\w"; fi)'
    PS1=$ORANGE'┌'$GREEN' \u '$DEFAULT$DIR'\n'$ORANGE'└'$DEFAULT' '
    
else 
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w $ '
fi

# FUNCTIONS
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
