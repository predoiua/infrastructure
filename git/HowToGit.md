
# Common operations

##Get rid of local modification

~~~bash
git reset --hard HEAD
~~~

##Mark file as unchanged.

~~~bash
git update-index --assume-unchanged file
~~~

##Checkout locally a remote branch

~~~bash
git fetch
git checkout branch
~~~

##Create locally a new branch

~~~bash
#check if we are in correct branch
git branch
git branch new_branch
git checkout new_branch
~~~

##Show files modified in a commit

~~~bash
#http://stackoverflow.com/questions/424071/list-all-the-files-for-a-commit-in-git
git diff-tree --no-commit-id --name-only -r commit_sha

git show --pretty="format:" --name-only commit_sha
~~~

##Delete a branch

~~~bash
#local
git branch -d the_local_branch
#remote
git push origin --delete the_remote_branch
~~~
