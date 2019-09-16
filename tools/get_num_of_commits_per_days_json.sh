# Returns json with days and corresponding number of commits scheduled for that day
# USAGE: ./get_num_of_commits_per_days_json.sh

counter=1
numOfCommits=`./get_days_with_scheduled_commits.sh | wc -l`

echo "{"
for day in $(./get_days_with_scheduled_commits.sh); do
    if [[ "$counter" != "$numOfCommits" ]]; then
		echo \"$day\"":"$(./get_num_of_commits_per_day.sh $day),
	else
		echo \"$day\"":"$(./get_num_of_commits_per_day.sh $day)
	fi
    counter=$((counter + 1))
done
echo "}"
