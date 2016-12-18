#!/bin/bash
usage()
{
    echo "USE mtr_10min_report.sh {IP_address}";
    exit 1;

}

if { test -z $1;  }
then
     usage;
   else
  /usr/bin/mtr --report --report-wide --report-cycles 600 $1
fi
