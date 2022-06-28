#!/bin/bash
#source /etc/profile
./home/bin/restart_service.sh -l & pid=$! && sleep 10 && kill "$pid"
