ARG BASE_TAG="develop"
ARG BASE_IMAGE="core-ubuntu-focal"
FROM kasmweb/$BASE_IMAGE:$BASE_TAG
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME


######### Customize Container Here ###########

RUN apt-get update && apt-get install -y obs-studio pulseaudio pulseaudio-utils pulseaudio-module-zeroconf

COPY assets/background.png $HOME/Desktop/

COPY assets/HDSDR/ $HOME/Desktop/

COPY src/ubuntu/install/wine/install_wine.sh $HOME/
RUN bash $HOME/install_wine.sh

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
