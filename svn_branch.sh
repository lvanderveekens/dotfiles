BRANCH=$(svn info 2> /dev/null | grep "Relative URL" | awk '{sub("branches/",""); sub("\\^/",""); sub("/"," "); sub("/"," "); printf "("$3" ߂ "$4")"; for (i=5; i<=NF;i++) printf "\033[01;34m "$i"\033[00m "}') 

echo "$BRANCH"
