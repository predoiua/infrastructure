# YUM (Yellowdog Updater Modified)

YUM is a repository management tool which will fetch the appropriate package for your particular version of Linux(along with all other required packages).
RPM is the package manager tool which installs the package.

## Usage

~~~
yum install <package name/s>   # install the latest version of a package or group of packages
yum update <package name/s>    # update the specified package, no package name/s are specified = to update all installed packages.
yum check-update               # determine whether any updates are available for your installed packages.
yum remove <package name/s>    # remove specified packages, along with any other packages dependent on the packages being removed.
yum provides <file name>       # Used to determine which packages provide a specific file or feature.

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

