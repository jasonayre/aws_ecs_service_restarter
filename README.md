# AWS ECS Service Restarter
This allows you to periodically restart an ECS service via a cron job.

## Example Compose Usage
Make sure to expose a secret named aws-access-key-id and aws-secret-access-key to the service. Everything else is handled via ENV variables

``` yml
secrets:
aws-access-key-id:
  file: './aws-access-key-id'
aws-secret-access-key:
  file: './aws-secret-access-key'
services:
  restarter:
    image: peer60/aws_ecs_service_restarter:1.0
    environment:
      SERVICE: staging-SubscriberService-12345
      CLUSTER: staging
      AWS_DEFAULT_REGION: us-east-1
      CRON_SCHEDULE: "*/1 * * * *"
    secrets:
      - aws-access-key-id
      - aws-secret-access-key
```
