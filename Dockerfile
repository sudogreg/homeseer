FROM debian:latest
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION="3_0_0_368"
ENV TIMEZONE="America/Chicago"

RUN apt-get update -q
RUN apt-get -y -q install wget
RUN wget http://download.mono-project.com/repo/xamarin.gpg
RUN apt-key add xamarin.gpg
RUN rm xamarin.gpg
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get update -q
RUN apt-get install -y \
      mono-complete \
      flite \
      chromium \
      locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && echo "$TIMEZONE" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

RUN wget -O tini.deb "https://github.com/krallin/tini/releases/download/v0.16.1/tini_0.16.1-amd64.deb" \
    && dpkg -i tini.deb \
    && rm tini.deb

RUN wget -O homeseer.tgz "http://homeseer.com/updates3/hs3_linux_${VERSION}.tar.gz" \
    && tar -xzo -C / -f /homeseer.tgz \
    && rm homeseer.tgz

COPY ["run.sh", "/"]

ENTRYPOINT ["tini", "--", "/run.sh"]
