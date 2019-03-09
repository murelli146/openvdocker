FROM debian:latest
MAINTAINER Gernot Klobucaric <murelli146>
COPY root / 
ENV PORTCLI 3002
ENTRYPOINT ["sh","/etc/vcontrold/run.sh"]
