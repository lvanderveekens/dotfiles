BRANCH=$(svn info 2> /dev/null | grep "Relative URL" | awk '{sub("branches/",""); sub("\\^/",""); sub("/"," "); sub("/"," "); printf "["$3"] \033[38;5;039m(߂ "$4")\033[00m"; for (i=5; i<=NF;i++) printf " "$i" "}') 

echo "$BRANCH"
