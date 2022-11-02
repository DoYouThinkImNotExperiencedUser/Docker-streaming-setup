FROM kasmweb/core-ubuntu-bionic:1.10.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME


######### Customize Container Here ###########

# background image
COPY assets/background.png  /usr/share/extra/backgrounds/bg_default.png

RUN apt update
RUN apt -y upgrade
# install obs and PulseAudio
RUN apt -y install obs
RUN apt -y install PulseAudio
# dependencies (Pulsemeeter)
RUN apt -y install python3-pip swh-plugins libgirepository1.0-dev libpulse-dev libappindicator3-dev
RUN apt -y install gir1.2-appindicator3-0.1
# PulseMeeter
RUN pip -y install pulsemeeter
RUN pulsemeeter daemon


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME