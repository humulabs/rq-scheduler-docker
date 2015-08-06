FROM phusion/baseimage:0.9.17

MAINTAINER Michael Keirnan <michael@keirnan.com>

ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python-pip
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update to regular PYPI release after logging bug fix is included
# https://github.com/ui/rq-scheduler/issues/82
RUN pip install https://github.com/ui/rq-scheduler/archive/8583d6f5c660bb720c902225922415b30d7248f8.zip

COPY etc/ /etc/
