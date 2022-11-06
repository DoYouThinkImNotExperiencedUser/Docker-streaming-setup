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
RUN dpkg --add-architecture i386 
RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/bionic/winehq-bionic.sources
RUN apt -y install --install-recommends winehq-stable
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