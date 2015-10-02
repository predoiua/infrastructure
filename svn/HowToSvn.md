
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
