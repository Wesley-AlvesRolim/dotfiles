#!/usr/bin/env bash

INTERVAL=0.5;
CPU_PERCENTAGE="";

main()
{
  while [[ true ]]; do
    sleep $INTERVAL;
    CPU_PERCENTAGE=$(top -bn1 |
      grep "CPU(s)" |
      sed "s/.*, *\([0-9.]*\)%* id.*/\1/" |
      awk '{print $1"%"}'
    );
    echo $CPU_PERCENTAGE;
  done;
}

main
