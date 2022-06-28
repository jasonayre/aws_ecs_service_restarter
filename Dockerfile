FROM ubuntu:latest
MAINTAINER jayre

# Add crontab file in the cron directory
RUN mkdir -p /home/bin
#ARG AWS_DEFAULT_REGION
#ARG SERVICE
#ARG CLUSTER
#ARG CRON_SCHEDULE
#RUN touch /etc/profile

#RUN echo "export AWS_ACCESS_KEY_ID='${AWS_ACCESS_KEY_ID}'\n" >> /etc/profile
#RUN echo "export AWS_SECRET_ACCESS_KEY='${AWS_SECRET_ACCESS_KEY}'\n" >> /etc/profile
#RUN echo "export AWS_DEFAULT_REGION='${AWS_DEFAULT_REGION}'\n" >> /etc/profile

#RUN touch /home/bin/restart_service.sh
#RUN echo "aws ecs update-service --force-new-deployment --service ${SERVICE} --cluster ${CLUSTER}"
COPY restart_service.sh /home/bin/restart_service.sh
RUN cat /home/bin/restart_service.sh
RUN chmod u+x /home/bin/restart_service.sh
RUN touch /etc/cron.d/run_cron

RUN echo "${CRON_SCHEDULE} root /home/bin/restart_service_in_background.sh >> /var/log/cron.log  2>&1 \n" >> /etc/cron.d/run_cron
RUN cat /etc/cron.d/run_cron

#RUN mkdir -p /run/secrets

#COPY AWS_ACCESS_KEY_ID /run/secrets/aws-access_key-id
#COPY AWS_SECRET_ACCESS_KEY /run/secrets/AWS_SECRET_ACCESS_KEY
COPY aws /home/aws
RUN /bin/bash -c whoami


RUN ./home/aws/install -i /home/aws-cli
COPY restart_service_in_background.sh /home/bin/restart_service_in_background.sh
RUN chmod u+x /home/bin/restart_service_in_background.sh

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

# Run the command on container startup

CMD cron && tail -f /var/log/cron.log
