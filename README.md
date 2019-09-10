# Autocommiter - scheduling commits
Autocommiter is simple tool for making commits automatically at certain time.  
Features:  
* Support for multiple repositories
* Configurable author per commit

## Copy directory structure  
Use below command to copy structure from 2019-09-09_1 to all greped directories  
	ls | grep '2019-10' | xargs -I % cp -r 2019-09-09_1/* %  

