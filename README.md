# Docker-streaming-setup
[PulseAudio](https://github.com/pulseaudio/pulseaudio) , [obs](https://github.com/obsproject/obs-studio) and [PulseMeeter](https://github.com/theRealCarneiro/pulsemeeter#installation) pre-installed [core-ubuntu-focal](https://hub.docker.com/r/kasmweb/core-ubuntu-focal) docker container

Template copied from https://github.com/ChristianLempa/hackbox/blob/main/src/Dockerfile and edited for other use


# Important note
~~**Please note this was not tested yet and i don't even know if its working** I don't really have Kasm instance running, i had but like too lazy to spin it up again, also too lazy to test on my own machine~~ This was tested as of now but not yet with full kasm instance running

- Installs OBS [YES]
- installs PulseAudio [YES]
- Installs PulseMeeter [NO]
- Changes background to 6969x6969 resolution black png image [NO]
- Installs wine [YES]
- Copies HDSDR and install script to the user home folder [YES]
<br>
(YES/NO in square brackets indicates if it currently works or not)

also im not really experienced docker user

oh yeah this is image for [Kasm](https://www.kasmweb.com/)




**uploading to docker registry soon, you can do it yourself too tho**

## How to build?
run
```
git clone https://github.com/DoYouThinkImNotExperiencedUser/Docker-streaming-setup.git
```
open terminal in that directory and then run
```
sudo docker build -t docker-streaming-setup .
```
run `sudo docker images` to see list of images, if you don't see "4not3/docker-streaming-setup" its fine, just copy id of latest created one it should be there

### How to run?
```
docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password docker-streaming-setup
```
Password will be password and user is kasm_user
