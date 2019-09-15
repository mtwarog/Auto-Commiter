# Resturns list of all scheduled commits
# USAGE: ./get_scheduled_commits.sh

currentDate=`date +'%Y-%m-%d'`
previousCommitDate=""

cd ../data
for f in *; do
  # comparing dates
  if [[ $currentDate < "${f:0:10}" ]]; then
	# check if previous commit date was the same
	if [ $previousCommitDate != "${f:0:10}" ]; then
		echo ${f:0:10}
	fi
  fi
  previousCommitDate=${f:0:10}
done
