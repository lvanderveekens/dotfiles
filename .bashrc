# my bashrc containing aliases and environment variables

### ALIASES
alias b='mvn clean install'
alias startw='VBoxManage startvm Windows7 --type headless'

# ANSI color codes
GREEN='\[\e[01;32m\]'
DEFAULT='\[\e[00m\]'
ORANGE='\[\e[38;5;202m\]'

if [ "$color_prompt" = yes ]; then
    W='$(if [ -n "$(get_branch_and_dir)" ]; then echo -e "$(get_branch_and_dir)"; else echo "\e[00m\w"; fi)'
    PS1=$ORANGE'┌'$GREEN' \u '$DEFAULT$W'\n'$ORANGE'└'$DEFAULT' '
else 
    PS1='\u@\h:\w $ '
fi

### FUNCTIONS
log() {
    svn log "$@" | 
    awk '{ if ($3 == "luciano")  {
               printf "%s%s%s\n", "\033[1;1m", $0, "\033[00m"
           } else {
               print $0
           }
    }' | less -R
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
           printf "%s[%s]%s %s(%s) %s", "\033[1;1m" ,$3, "\033[00m", "\033[1;1m", $4, "\033[00m";
           for (i=5; i<=NF;i++) { 
               if (i==5) {
                   printf "/"$i
               } else {
                   printf " "$i" "
               }
           } 
       }'
}

