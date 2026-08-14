# Common operations



~~~bash
git reset --hard HEAD   # Get rid of local modification
git checkout path/to/file/to/revert     # not in index
git checkout -- .                       # For all unstaged files use:
git reset --hard HEAD~1 # Delete a local commit
git update-index --assume-unchanged file  # Mark file as unchanged.
git commit --ammend   # fix commit message
git add -p     # patch = chose what goes in commit
git bisect     # for debug
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

~~~ bash
git stash
# chekcout a diff brach or whatever
git stash pop
~~~


## Remove file from index

~~~
git reset HEAD <file>
git reset HEAD -- .
~~~


## diff



~~~bash
# diff
# http://stackoverflow.com/questions/1587846/how-do-i-show-the-changes-which-have-been-staged
git diff                  # working folder vs index
git diff --cached         # index vs HEAD
git diff HEAD             # HEAD vs working folder
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
git clean -fd            # -f = force, -d = include folders, -n = dry run
~~~

## EOL auto convert

~~~
git config --list --show-origin           | grep autocrlf
git config --global core.autocrlf false
~~~

## Undo last merge

~~~
git reset --hard HEAD~1              # delete last merge
git pull --rebase origin master      # pull with rebase            
~~~

## Branch 

### Checkout locally a remote branch

~~~bash
git fetch
git checkout branch
~~~

### Create locally a new branch

~~~bash
#check if we are in correct branch
git branch
git branch new_branch
git checkout new_branch
~~~

### Show files modified in a commit

~~~bash
#http://stackoverflow.com/questions/424071/list-all-the-files-for-a-commit-in-git
git diff-tree --no-commit-id --name-only -r commit_sha
git show --pretty="format:" --name-only commit_sha
~~~

### Delete a branch

~~~bash
git branch -d the_local_branch               # local
git branch -D the_local_branch               # force a local delete
git push origin --delete the_remote_branch   # remote
~~~

### Create branch from specific commit SHA

~~~bash
git checkout -b branch-name <commit>
~~~

### Apply modifications from branch without merge

~~~bash
git merge --no-commit --squash branchA   
git reset HEAD                          # to unstage the changes
~~~

### rename branch

http://stackoverflow.com/questions/6591213/how-do-i-rename-the-local-branch
-m is for "move" (or mv), which is how you rename files.

~~~
git branch -m <oldname> <newname>
git branch -m <newname>                       #rename current branch
~~~

### Get branch name

~~~bash
#http://git-blame.blogspot.ro/2013/06/checking-current-branch-programatically.html
git rev-parse --abbrev-ref HEAD
git symbolic-ref --short -q HEAD
~~~

