# AWS ECS Service Restarter
This allows you to periodically restart an ECS service via a cron job. It uses docker build arguments to specify the environment variables/flags.

### Building Example
```docker build . --build-arg AWS_ACCESS_KEY_ID="12345" --build-arg AWS_SECRET_ACCESS_KEY="123123" --build-arg PORTAINER_SERVICE_NAME="subscriber" --build-arg PORTAINER_USERNAME="user" --build-arg PORTAINER_PASSWORD="password" --build-arg CRON_SCHEDULE="*/5 * * * *" -t PrivateDockerHubUser/myimage:latest```


ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION
ARG SERVICE
ARG CLUSTER
ARG CRON_SCHEDULE
