FROM ubuntu:14.04

MAINTAINER Marcel Toele

RUN apt-get -y install curl
RUN curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update
RUN apt-get -y install google-chrome-stable
RUN apt-get -y install tightvncserver
RUN apt-get -y install bsdmainutils

ADD google-chrome /root/.config/google-chrome/Default/
ADD scripts /root/
RUN /root/configure-vnc.sh
ENTRYPOINT ["/root/bootvnc.sh"]

