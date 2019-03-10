FROM debian:latest
MAINTAINER Gernot Klobucaric <murelli146>
COPY root / 
ENV PORTCLI 3002
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install telnet libxml2-dev
ENTRYPOINT ["sh","/etc/vcontrold/run.sh"]
