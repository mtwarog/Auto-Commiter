#!/bin/bash
AUTOCOMMIT_DIR="/c/Users/maciejt/Desktop/AutoCommit"
LOG_FILE="/c/Users/maciejt/Desktop/AutoCommit/log.txt"

# read current date in format YYYY-MM-DD
currentDate=`date +'%Y-%m-%d'`
# change directory to new commits directory
cd $AUTOCOMMIT_DIR/data
# read number of commits to be commited
commitDirectoryRegex=$currentDate+"_[0-9]*"
numberOfCommits=`ls | grep -P "$commitDirectoryRegex" | wc -l`
# go through each commit
if [ "$numberOfCommits" -eq "0" ]; then 
	echo "$currentDate: No content to be commited" >> $LOG_FILE
	exit 0
fi
for (( c=1; c<=$numberOfCommits; c++ ))
	do
		# open commit number $c directory
		currentCommitDir=$AUTOCOMMIT_DIR/data/$currentDate"_"$c
		cd $currentCommitDir
		# read scheduled commit time
		TIME_FILE=$currentCommitDir/commit_time.txt
		if [ -f "$TIME_FILE" ]; then
			commitTime=`cat $currentCommitDir/commit_time.txt`
			echo "$AUTOCOMMIT_DIR/tools/push_commit.sh $AUTOCOMMIT_DIR/data $LOG_FILE $currentDate $c" | at $commit_time
		else 
			$AUTOCOMMIT_DIR/tools/push_commit.sh $AUTOCOMMIT_DIR/data $LOG_FILE $currentDate $c
		fi
done
exit 0