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
# Install obs
RUN apt -y install v4l2loopback-dkms
RUN add-apt-repository ppa:obsproject/obs-studio
RUN apt install obs-studio
# Install PulseAudio
RUN apt -y install PulseAudio
# pulsemeeter
RUN apt install python3-pip swh-plugins libgirepository1.0-dev libpulse-dev libappindicator3-dev
RUN apt install gir1.2-appindicator3-0.1
RUN pip install pulsemeeter
RUN pulsemeeter daemon
# wine
RUN apt-get install -y wget software-properties-common gnupg2 winbind xvfb

RUN dpkg --add-architecture i386
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN apt-key add winehq.key
RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
RUN apt-get update
RUN apt-get install -y winehq-stable

RUN apt-get install -y winetricks

RUN apt-get clean -y
RUN apt-get autoremove -y

ENV WINEDEBUG=fixme-all

RUN winetricks msxml6
## Copied from https://stackoverflow.com/questions/61815364/how-can-i-get-my-win32-app-running-with-wine-in-docker

# Copy HDSDR install script
COPY assets/HDSDR/HDSDR_install.exe /home/kasm-default-profile/Desktop/HDSDR_install.exe
COPY assets/HDSDR/install-hdsdr.sh /home/kasm-default-profile/Desktop/install-hdsdr.sh

# update
RUN apt -y update

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME