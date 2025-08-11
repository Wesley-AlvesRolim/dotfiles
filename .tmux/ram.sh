#!/usr/bin/env bash

INTERVAL=0.5;
MEM_USAGE="";

main()
{
  while [[ true ]]; do
    sleep $INTERVAL;
    MEM_USAGE=$(top -bn1 |
      grep "MB mem" |
      awk '{printf "%.2f GB\n", ($8 / 1000)}'
    );
    echo $MEM_USAGE;
  done;
}

main
