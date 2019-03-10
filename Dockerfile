FROM debian:latest
MAINTAINER Gernot Klobucaric <murelli146>
COPY root / 
ENV PORTCLI 3002
RUN apt-get install libxml2-dev
ENTRYPOINT ["sh","/etc/vcontrold/run.sh"]
