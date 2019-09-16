# Returns json with scheduled commits
# USAGE: ./get_scheduled_commits_json.sh

counter=1
numOfCommits=`./get_scheduled_commits.sh | wc -l`

echo "["
for commit in $(./get_scheduled_commits.sh); do
    if [[ "$counter" != "$numOfCommits" ]]; then
		echo \"$commit\",
	else
		echo \"$commit\"
	fi
    counter=$((counter + 1))
done
echo "]"
