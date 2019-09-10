#!/bin/bash

TO_BE_COMMITED_DIR="/root/autoCommiter/data"
LOG_FILE="/root/autoCommiter/log.txt"

# read current date in format YYYY-MM-DD
currentDate=`date +'%Y-%m-%d'`
# change directory to new commits directory
cd $TO_BE_COMMITED_DIR
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
		currentCommitDir=$TO_BE_COMMITED_DIR/$currentDate"_"$c
		cd $currentCommitDir
		# read remote and branch names
		remoteName=`cat $currentCommitDir/remote_name.txt`
		branchName=`cat $currentCommitDir/branch_name.txt`
		# read repository dir
		repositoryDir=`cat $currentCommitDir/repository_config.txt | grep 'REPOSITORY_DIR' | awk '{print $2}'`
		# read commit author name
		gitFirstName=`cat $currentCommitDir/repository_config.txt | grep 'GIT_FIRST_NAME' | awk '{print $2}'`
		gitLastName=`cat $currentCommitDir/repository_config.txt | grep 'GIT_LAST_NAME' | awk '{print $2}'`
		# read commit author email
		gitEmail=`cat $currentCommitDir/repository_config.txt | grep 'GIT_EMAIL' | awk '{print $2}'`
		# read commit message
		commitMessage=`cat $currentCommitDir/commit_message.txt`
		# cd to repository dir
		cd $repositoryDir
		# checkout to branch 
		git checkout $branchName
		# pull latest changes
		git pull $remoteName $branchName
		# copy files to commit
		cp -r $currentCommitDir/commit/* ./
		# set username and email for commit
		git config user.name "$gitFirstName $gitLastName"
		git config user.email "$gitEmail"
		# add all files to index
		git add .
		# commit with commit message
		git commit -m "$commitMessage"
		git push $remoteName $branchName
		echo "$currentDate: Pushed commit number $c with message \"$commitMessage\" to remote $remoteName ($repositoryDir) to branch $branchName" >> $LOG_FILE
done
exit 0
