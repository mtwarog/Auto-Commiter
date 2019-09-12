# Uploads multiple commits
# USAGE: ./upload_commite_from_list.sh PASSWORD_TO_REMOTE
cat upload_commits_list.txt | xargs -I % ./upload_commit.sh % $1 