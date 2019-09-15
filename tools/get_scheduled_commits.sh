# Resturns list of all scheduled commits
# USAGE: ./get_scheduled_commits.sh

currentDate=`date +'%Y-%m-%d'`

cd ../data
for f in *; do
  if [[ $currentDate < "${f:0:10}" ]]; then
	echo $f
  fi
done
