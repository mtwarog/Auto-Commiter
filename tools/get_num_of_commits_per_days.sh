# Returns number of commits scheduled for all future days
# USAGE: ./get_num_of_commits_per_days

for day in $(./get_days_with_scheduled_commits.sh); do
    echo `./get_num_of_commits_per_day.sh $day`
done
