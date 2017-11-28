#!/bin/bash
xhost +
docker run -it --privileged -v /tmp/.X11-unix:/tmp/.X11-unix --device=/dev/dri/card0:/dev/dri/card0 -e DISPLAY=$DISPLAY  -v /home/jmacey/:/home/host/jmacey $@


#docker run -it --privileged -e "DISPLAY=unix:0.0" -v="/tmp/.X11-unix:/tmp/.X11-unix:rw" $@
