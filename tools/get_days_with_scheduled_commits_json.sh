# Returns json with days having scheduled commits
# USAGE: ./get_days_with_scheduled_commits_json.sh

counter=1
numOfCommits=`./get_days_with_scheduled_commits.sh | wc -l`

echo "["
for day in $(./get_days_with_scheduled_commits.sh); do
    if [[ "$counter" != "$numOfCommits" ]]; then
		echo \"$day\",
	else
		echo \"$day\"
	fi
    counter=$((counter + 1))
done
echo "]"
