#!/bin/bash
usage()
{
  echo "USE ngrep.sh {nomer linii}";
  exit 1;
}

if { test -z $1; }
then
   usage;
else
   ngrep -t -d any $1 udp -q -W byline
fi
