# YUM (Yellowdog Updater Modified)

YUM is a repository management tool which will fetch the appropriate package for your particular version of Linux(along with all other required packages).
RPM is the package manager tool which installs the package.

## Usage

~~~
# install the latest version of a package or group of packages
yum install <package name/s> 

# update the specified packages to the latest available version.  if no package name/s are specified, then yum will attempt to update all installed packages.
yum update <package name/s> 

# determine whether any updates are available for your installed packages. yum returns a list of all package updates from all repositories if any are available.
yum check-update

# remove specified packages, along with any other packages dependent on the packages being removed.
yum remove <package name/s> 

# Used to determine which packages provide a specific file or feature.
yum provides <file name> 

# used to find any packages containing the specified keyword in the description, summary, packager and package name fields of RPMs in all repositories.
yum search <keyword> 

# install a package located locally in the machine.
yum localinstall <absolute path to package name/s> 

# check if package is installe install
yum list installed <package name/s> 
~~~

## Options

~~~
# Answer "yes" to every question in the transaction
yum -y ...
~~~

## Configuration

* /etc/yum.conf

~~~
# PUT YOUR REPOS HERE OR IN separate files named file.repo
# in /etc/yum.repos.d
~~~

