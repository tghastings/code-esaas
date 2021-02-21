FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash
ENV GIT_EDITOR=nano
RUN apt update \
  && apt install -y zlib1g-dev ruby-full libsqlite3-dev libffi-dev libpq-dev nodejs npm curl supervisor zsh git nano vim\
  && gem install rails -v 5.2.4 \
  && gem install bundler \
  && curl -o- -L https://yarnpkg.com/install.sh | bash \
  && export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH" \
  && curl https://cli-assets.heroku.com/install.sh | sh \
  && curl -fsSL https://code-server.dev/install.sh | sh \
  && mkdir -p /var/log/supervisor

ADD supervisord.conf /etc/

EXPOSE 80 3000

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
