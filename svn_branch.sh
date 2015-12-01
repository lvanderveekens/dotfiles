get_branch() {
    awk '{ sub("branches/",""); 
           sub("\\^/",""); 
           sub("/"," "); 
           sub("/"," "); 
           printf "\033[38;5;039m["$3"]\033[00m \033[38;5;039m⎇  "$4"\033[00m"; 
           for (i=5; i<=NF;i++) { 
               if (i==5) {
                   printf "/"$i
               } else {
                   printf " "$i" "}
           } 
       }'
}

BRANCH=$(svn info 2> /dev/null | grep "Relative URL" | get_branch )

echo "$BRANCH"
