#!/bin/bash

BACKUPLOCATION=/var/local/mysqlbackups

mkdir -p $BACKUPLOCATION

# back up all the mysql databases, into individual files so we can later restore
# them separately if needed.
mysql --defaults-extra-file=/root/.mmy.cnf -B -N -e "show databases" | while read db
do
   BACKUPFILE=$BACKUPLOCATION/$db.mysql
   echo "Backing up $db into $BACKUPFILE"
   /usr/bin/mysqldump --defaults-extra-file=/root/.mmy.cnf --flush-privileges --single-transaction --master-data --set-gtid-purged=auto --flush-logs --triggers --routines --events --hex-blob $db > $BACKUPFILE
done

cd $BACKUPLOCATION

tar -czf $BACKUPLOCATION/mysql-`hostname -s`-`date +%Y-%m-%d`.tar.gz *.mysql

rm -f $BACKUPLOCATION/*.mysql

