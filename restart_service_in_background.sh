#!/bin/bash
/home/bin/restart_service.sh -l & pid=$! && sleep 10 && pkill -9 restart_service
