#!/bin/sh
./check_mesos.py -H 192.168.1.10 | tee "status-"`date '+%Y%m%d-%H%M%S'`".log"
