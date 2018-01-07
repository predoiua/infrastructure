# SVN

## Useful commands

~~~sh
svn checkout svn://localhost/xx ~/build/xx  # checkout a branch/trunk
svn info                                    # show details about source

cd ~/build/xx
svn up .                                    # update to latest version
svn up -rXXXX                               # checkout a revision
svn status                                  # view modified files
svn revert -R .                             # revert local modification
~~~

## Create new branch with Tortoise

- Right click on trunk -> Select: Branch/Tag...
- Select branch location : /branches/...
Obs: Truck is not affected.

## Apply a patch with Tortoise

- Right click on branch -> Select:Merge...
- Click "Show log" button : select commit
- Click "Test Merge"
- Merge
- Do work
- Commit merge


