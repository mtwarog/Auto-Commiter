# Uploads specified commit from local autocommiter to autocommiter on remote
# USAGE: ./upload_commmit YYYY-MM-DD_X password_to_host

USER="" # user to log in on host e.g. "root" 
HOST="" # host with autocommiter installed e.g "example.com"
LOCAL_PATH=".." # path to local autocommit main directory (by default "..")
REMOTE_PATH="" #path to autocommit main directory on HOST e.g. "~/autoCommiter"

COMMIT_DIR_NAME=$1
PASSWORD=$2

# scp commit directory and it's content to remote autocommiter/data directory
sshpass -p $PASSWORD scp -r $LOCAL_PATH/data/$COMMIT_DIR_NAME $USER@$HOST:$REMOTE_PATH/data/
# log into remote and run converter script
echo "cd $REMOTE_PATH/tools;./convert_to_unix_end_lines.sh;exit" | sshpass -p $PASSWORD ssh -t $USER@$HOST  
