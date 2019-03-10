FROM debian:latest
MAINTAINER Gernot Klobucaric <murelli146>
COPY root / 
ENV PORTCLI 3002
ports:
  - target: 3002
    published: 3002
    protocol: tcp
    mode: host
ENTRYPOINT ["sh","/etc/vcontrold/run.sh"]
