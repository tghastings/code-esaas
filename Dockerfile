FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update \
  && apt install -y zlib1g-dev ruby-full libsqlite3-dev nodejs npm curl supervisor \
  && gem install rails \
  && curl -o- -L https://yarnpkg.com/install.sh | bash \
  && export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH" \
  && curl -fsSL https://code-server.dev/install.sh | sh \
  && mkdir /root/environment \
  && mkdir -p /var/log/supervisor

ADD supervisord.conf /etc/

VOLUME /root/environment

EXPOSE 80 3000

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
