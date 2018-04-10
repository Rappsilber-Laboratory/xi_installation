#!/bin/sh
# This script sets some values in php.ini files needed for searchSubmit to upload large files and to use a PGSQL database

# find all instances of php.ini in this directory
array=()
find . -name php.ini -print0 >tmpfile
while IFS=  read -r -d $'\0'; do
    array+=("$REPLY")
done <tmpfile
rm -f tmpfile

# and then replace the max sizes in those php.ini's with 4G, and enable the pgsql functionality
for i in "${array[@]}"
do
  echo "$i"
  sed -i.bak -e "s/^post_max_size=.*/post_max_size=4G/" -e "s/^upload_max_filesize=.*/upload_max_filesize=4G/" -e "s/^;extension=php_pdo_pgsql.dll/extension=php_pdo_pgsql.dll/" -e "s/^;extension=php_pgsql.dll/extension=php_pgsql.dll/" "$i"
done
