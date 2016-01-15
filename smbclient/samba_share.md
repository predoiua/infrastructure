# How to copy file from a Win Share folder in linux

## Install

CentOS

~~~
sudo yum install samba-client
~~~

## Usage

recurse ON = recursive call
prompt = disable confirmation
lcd = local cd

~~~bash
smbclient \\\\server_name\\public --user='AD\username%password'
lcd ~/Download
cd "dir name"
get file.txt
recurse ON
prompt OFF
mget "folder name"
~~~

