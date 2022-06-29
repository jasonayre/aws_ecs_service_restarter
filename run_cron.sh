#!/bin/bash
echo "" >> /etc/profile
echo "export SERVICE=${SERVICE}" >> /etc/profile
echo "export CLUSTER=${CLUSTER}" >> /etc/profile
echo "export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}" >> /etc/profile
echo "export AWS_ACCESS_KEY_ID=$(cat /run/secrets/aws-access-key-id)" >> /etc/profile
echo "export AWS_SECRET_ACCESS_KEY=$(cat /run/secrets/aws-secret-access-key)" >> /etc/profile
echo "${CRON_SCHEDULE} root /home/bin/restart_service_in_background.sh >> /var/log/cron.log  2>&1 \n" >> /etc/cron.d/run_cron
service cron reload
cron && tail /var/log/cron.log
