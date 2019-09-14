# Deletes specified files, copies commit files and pushes them to specified repository
# USAGE: ./push_commit TO_BE_COMMITED_DIR LOG_FILE currentDate commit_id

TO_BE_COMMITED_DIR=$1
LOG_FILE=$2

currentDate=$3
commit_id=$4

# open commit number $c directory
currentCommitDir=$TO_BE_COMMITED_DIR/$currentDate"_"$commit_id
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
# delete specified files 
DELETE_FILE=$currentCommitDir/files_to_delete.txt
if [ -f "$DELETE_FILE" ]; then
	while read fileToDelete; do
		rm fileToDelete
	done < $currentCommitDir/files_to_delete.txt # this file must contain paths to files relative to main directory of repository
fi
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
echo "$currentDate: Pushed commit number $c with message $commitMessage to remote $remoteName ($repositoryDir) to branch $branchName" >> $LOG_FILE