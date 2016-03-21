
# Common operations

## Get rid of local modification

~~~bash
git reset --hard HEAD
~~~

## Mark file as unchanged.

~~~bash
git update-index --assume-unchanged file
~~~

## Checkout locally a remote branch

~~~bash
git fetch
git checkout branch
~~~

## Create locally a new branch

~~~bash
#check if we are in correct branch
git branch
git branch new_branch
git checkout new_branch
~~~

## Show files modified in a commit

~~~bash
#http://stackoverflow.com/questions/424071/list-all-the-files-for-a-commit-in-git
git diff-tree --no-commit-id --name-only -r commit_sha

git show --pretty="format:" --name-only commit_sha
~~~

## Delete a branch

~~~bash
#local
git branch -d the_local_branch
#force a local delete
git branch -D the_local_branch
#remote
git push origin --delete the_remote_branch
~~~

## Delete a local commit

~~~bash
git commit ...
git reset --soft HEAD~1
... edit files ...
git add ...
git commit -c ORIG_HEAD
~~~

## Stash

Save temporary your work

~~~
git stash
# chekcout a diff brach or whatever
git stash pop
~~~

## Get rid of local modifications ( file are not in index )

http://stackoverflow.com/questions/52704/how-do-you-discard-unstaged-changes-in-git

~~~
git checkout path/to/file/to/revert
#For all unstaged files use:
git checkout -- .
~~~

## Get branch name

~~~
#http://git-blame.blogspot.ro/2013/06/checking-current-branch-programatically.html
git rev-parse --abbrev-ref HEAD
git symbolic-ref --short -q HEAD
~~~

## Remove file from index

I "git add <file>" , but I dont want it in this commit

~~~
git reset HEAD <file>
~~~

## Fix commit message

http://stackoverflow.com/questions/179123/edit-an-incorrect-commit-message-in-git

~~~
git commit --ammend
~~~