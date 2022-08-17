# Ubuntu Bash Script

```bash

# cat /etc/shells
/bin/sh
/bin/dash
/bin/bash
/bin/rbash

# which bash
/bin/bash

# touch hello.sh
#! /bin/bash
echo $BASH
echo $BASH_VERSION
echo $HOME
echo $PWD
echo "Hello Bash Script"

echo "Input names: "
read name1 name2 name3
echo "Output names: $name1 $name2 $name3"

read -p 'Input username: ' username
echo "Username: $username"

read -sp 'Password: ' password
echo "Password: $password"

# chmod +x hello.sh
# ./hello.sh or sh hello.sh

```


## Shell Scripting Tutorial for Beginners 3 - Read User Input
https://www.youtube.com/watch?v=AcSkkNAsGCY&list=PLS1QulWo1RIYmaxcEqw5JhK3b-6rgdWO_&index=3
https://youtu.be/AcSkkNAsGCY?list=PLS1QulWo1RIYmaxcEqw5JhK3b-6rgdWO_&t=647