
* Useful commands

~~~sh
# checkout a branch/trunk
svn checkout svn://localhost/xx ~/build/xx

# show details about source
svn info

# update to latest version
cd ~/build/xx
svn up .


# checkout a revision
svn up -rXXXX

# view modified files
svn status

# revert local modification
svn revert -R .

~~~

* Create new branch with Tortoise

- Right click on trunk -> Select: Branch/Tag...
- Select branch location : /branches/...
Obs: Truck is not affected.

* Apply a patch with Tortoise

- Right click on branch -> Select:Merge...
- Click "Show log" button : select commit
- Click "Test Merge"
- Merge
- Do work
- Commit merge


