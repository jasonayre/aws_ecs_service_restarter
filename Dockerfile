FROM ubuntu:latest
MAINTAINER jayre
ARG CRON_SCHEDULE="1 * * * *"
ENV CRON_SCHEDULE=$CRON_SCHEDULE
ENV AWS_DEFAULT_REGION="us-east-1"
ENV SERVICE="someservice"
ENV CLUSTER="clustername"
# Add crontab file in the cron directory
RUN mkdir -p /home/bin

COPY run_cron.sh /home/bin/run_cron.sh
RUN chmod u+x /home/bin/run_cron.sh
COPY restart_service.sh /home/bin/restart_service.sh
RUN chmod u+x /home/bin/restart_service.sh
RUN touch /etc/cron.d/run_cron
RUN echo "" >> /etc/cron.d/run_cron
COPY aws /home/aws
RUN ./home/aws/install -i /home/aws-cli
COPY restart_service_in_background.sh /home/bin/restart_service_in_background.sh
RUN chmod u+x /home/bin/restart_service_in_background.sh
RUN chmod u+x /home/aws-cli/v2/current/bin/aws

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/run_cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

#Install Cron
RUN apt-get update
RUN apt-get -y install cron
RUN apt-get -y install jq
RUN apt-get -y install curl
RUN apt-get -y install bc
RUN apt-get -y install less

# Run the command on container startup
CMD ./home/bin/run_cron.sh && tail -f /var/log/cron.log
