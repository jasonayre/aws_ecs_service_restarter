#aws ecs update-service --force-new-deployment --service my-service --cluster cluster-name
#!/bin/bash
#source /etc/profile
echo $SERVICE
echo $CLUSTER
echo $AWS_ACCESS_KEY_ID

var AWS_ACCESS_KEY_ID = $(cat /run/secrets/aws-access-key-id)
var AWS_SECRET_ACCESS_KEY = $(cat /run/secrets/aws-secret-access-key)
export AWS_ACCESS_KEY_ID='${AWS_ACCESS_KEY_ID}'
export AWS_SECRET_ACCESS_KEY='${AWS_SECRET_ACCESS_KEY}'

#echo "export AWS_ACCESS_KEY_ID='${AWS_ACCESS_KEY_ID}'\n" >> /etc/profile

aws ecs update-service --force-new-deployment --service $SERVICE --cluster $CLUSTER
