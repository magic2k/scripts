#!/bin/bash
base_dir=dbs
string=$(ls ./${base_dir}/)
IPS=""
IPS='' read -d ' ' -a array <<< "$string"


for database in "${array[@]}"
do
#  echo $database
  curl -X PUT http://127.0.0.1:5984/$database
  ./couchdb-backup.sh -r -H 127.0.0.1:5984 -f ./$base_dir/$database -d $database
done

