#!/bin/bash
source /etc/profile
/usr/local/bin/aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
/usr/local/bin/aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
/usr/local/bin/aws sts get-caller-identity
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY /usr/local/bin/aws ecs update-service --force-new-deployment --service $SERVICE --cluster $CLUSTER
