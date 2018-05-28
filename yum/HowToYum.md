# YUM (Yellowdog Updater Modified)

YUM is a repository management tool which will fetch the appropriate package for your particular version of Linux(along with all other required packages).
RPM is the package manager tool which installs the package.

## Usage

~~~
yum whatprovides '*bin/dig'    # which program provide a program
yum install <package name/s>   # install the latest version of a package or group of packages
yum update <package name/s>    # update the specified package, no package name/s are specified = to update all installed packages.
yum check-update               # determine whether any updates are available for your installed packages.
yum remove <package name/s>    # remove specified packages, along with any other packages dependent on the packages being removed.
yum provides <file name>       # Used to determine which packages provide a specific file or feature.
yum search <keyword>           # used to find any packages containing the specified keyword in the description, summary, packager and package name fields 
yum localinstall <absolute pack name> # install a package located locally in the machine.
yum list installed <package name/s>   # check if package is installe install
~~~

~~~
yum grouplist hidden   # list all groups of pakages
yum groupinstall MATE Desktop
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


~~~
http_caching=packages        # to solve invalid repository metadata. default value = all
~~~