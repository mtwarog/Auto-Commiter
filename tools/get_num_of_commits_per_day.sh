# Returns number of commits scheduled for specific day
# USAGE ./get_num_of_commits_per_day YYYY-MM-DD

DATE=$1

cd ../data
echo "`ls | grep $DATE | wc -l`"
