FROM ubuntu:21.04

ENV TERM xterm
RUN echo "[$(tput setaf 6)INFO$(tput sgr0)] Start to build docker"

# update
RUN apt-get update -y
RUN echo "[$(tput setaf 6)INFO$(tput sgr0)] Update finished"

# set timezone
ARG TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
&&  echo $TZ > /etc/timezone
# set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
# create directory
RUN mkdir -p /workdir /logs
RUN chmod -R 777 /workdir /logs
# spare
EXPOSE 5006
RUN echo "[$(tput setaf 6)INFO$(tput sgr0)] Setting finished"

# base
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo bash-completion zsh man-db highlight zip rsync tzdata locales software-properties-common
# utils
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    neovim git git-lfs wajig curl wget proxychains openssh-server apt-transport-https
# nodejs
RUN apt-get install -y --no-install-recommends \
    nodejs npm \
&&  npm install -g n
RUN n latest
RUN npm install -g configurable-http-proxy
#zsh
RUN chsh -s /bin/zsh root
# brew
RUN git clone https://github.com/Homebrew/brew /workdir/.linuxbrew/Homebrew
# powerline
RUN wget https://raw.githubusercontent.com/powerline/powerline/develop/font/10-powerline-symbols.conf -O /workdir/10-powerline-symbols.conf
RUN wget https://raw.githubusercontent.com/powerline/powerline/develop/font/PowerlineSymbols.otf -O /workdir/PowerlineSymbols.otf
RUN mkdir -p /usr/share/fonts/OTF
RUN cp /workdir/10-powerline-symbols.conf /usr/share/fonts/OTF/
RUN mv /workdir/10-powerline-symbols.conf /etc/fonts/conf.d/
RUN mv /workdir/PowerlineSymbols.otf /usr/share/fonts/OTF/
RUN echo "[$(tput setaf 6)INFO$(tput sgr0)] Utils finished!"

# clean
RUN npm cache clean --force
RUN apt-get autoremove -y
RUN apt-get clean -y
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds
RUN echo "[$(tput setaf 6)INFO$(tput sgr0)] Cleaning finished"

# copy files
COPY scripts /scripts
COPY settings /settings
RUN echo "[$(tput setaf 6)INFO$(tput sgr0)] Copying finished"

RUN echo "[$(tput setaf 6)INFO$(tput sgr0)] End to build docker"