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
git branch -d the_local_branch               # local
git branch -D the_local_branch               # force a local delete
git push origin --delete the_remote_branch   # remote
~~~

## Delete a local commit

~~~
git reset --hard HEAD~1
~~~

## Redo a local commit

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
git checkout -- .                        #For all unstaged files use:
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
git reset HEAD -- .
~~~

## Fix commit message

http://stackoverflow.com/questions/179123/edit-an-incorrect-commit-message-in-git

~~~
git commit --ammend
~~~


## diff

http://stackoverflow.com/questions/1587846/how-do-i-show-the-changes-which-have-been-staged

~~~
git diff                  # working folder vs index
git diff --cached         # index vs HEAD
git diff HEAD             # HEAD vs working folder
~~~

## rename branch

http://stackoverflow.com/questions/6591213/how-do-i-rename-the-local-branch
-m is for "move" (or mv), which is how you rename files.

~~~
git branch -m <oldname> <newname>
git branch -m <newname>                       #rename current branch
~~~

## get an older file

~~~
git checkout COMMIT_SHA file/to/restore
~~~

## Disable passwd input popup on Win

~~~
git config --global core.askPass ""
~~~

## Clean local untracked files/folders

~~~
git clean -fd                            # -f = force, -d = include folders, -n = dry run
~~~


## Apply modifications from branch without merge

~~~
git merge --no-commit --squash branchA   
git reset HEAD                          # to unstage the changes
~~~

## EOL auto convert

~~~
git config --list --show-origin           | grep autocrlf
git config --global core.autocrlf false
~~~