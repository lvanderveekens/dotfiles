export LIGHTBLUE='\033[38;5;039m'
export RED_FG='\033[41;01m'
export NO_COLOR='\033[00m'

get_branch() {
    awk '{ sub("branches/",""); 
           sub("\\^/",""); 
           sub("/"," "); 
           sub("/"," "); 
           printf "%s%s%s ⎇  %s", ENVIRON["RED_FG"], $3, ENVIRON["NO_COLOR"], $4;
           for (i=5; i<=NF;i++) { 
               if (i==5) {
                   printf "/"$i
               } else {
                   printf " "$i" "
               }
           } 
       }'
}

BRANCH=$(svn info 2> /dev/null | grep "Relative URL" | get_branch )

echo -e "$BRANCH"
