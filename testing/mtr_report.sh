#!/bin/bash
# Mtr report script. Stores reports in files for every hour with 10 min(600 cycles) reports.
# Should be run in cron every 10 minutes 
#(*/10 *     * * *   root   mtr_report.sh)
FILE=/var/somefile_mtr-`date +%Y-%m-%d-%H-%m`.txt
date >> $FILE
/usr/bin/mtr --report --report-wide --report-cycles 600 127.0.0.1 >> $FILE

