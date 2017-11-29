#set the base image
FROM centos:7
# Dockerfile author / maintainer 
MAINTAINER Jon Macey  <jmacey@bournemouth.ac.uk> 
# Set some arguments for finding the nvidia drivers
ARG nvidiaRun=NVIDIA-Linux-x86_64-375.66.run
ARG nvidiaLocation=http://us.download.nvidia.com/XFree86/Linux-x86_64/375.66/NVIDIA-Linux-x86_64-375.66.run
# Maya dependancies from here 
# https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2016/ENU/Installation-Maya/files/GUID-D2B5433C-E0D2-421B-9BD8-24FED217FD7F-htm.html

RUN yum install -y gcc  wget \
    vim csh tcsh \
    compat-libtiff3.x86_64 \
    wget libpng12 && \
    yum install -y mesa-libGLw \
    gamin audiofile audiofile-devel e2fsprogs-libs \
    libXp libXmu libXpm \
    libXt libXi libXex libX11 \
    libXinerama libXau libxcb \
    libpthread libc libdl \
    libz librt libSM libXrender* \
    libICE libutil libssl libcrypto libGLU libXcomposite libxslt \
    pulseaudio-libs libGL-devel  \
    liberation-mono-fonts liberation-fonts-common \
    xorg-x11-fonts-75dpi* xorg-x11-fonts-ISO8859-1* \
    xorg-x11-fonts-100dpi* \
    liberation-sans-fonts liberation-serif-fonts dbus && \
cd /opt && \
wget ${nvidiaLocation} &>/dev/null && \
chmod +x $nvidiaRun  && \
./$nvidiaRun  -s -N --no-kernel-module &>/dev/null && \   
rm $nvidiaRun  && \
dbus-uuidgen > /var/lib/dbus/machine-id && \
echo "MAYA_DISABLE_CIP=1" >> ~/maya/2017/Maya.env && \
echo "LC_ALL=C" >> ~/maya/2017/Maya.env && \
echo "MAYA_OGS_GPU_MEMORY_LIMIT = 1024" >> ~/maya/2017/Maya.env

WORKDIR /home/ncca
ENV HOME /home/ncca
ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb
# set default command
ENTRYPOINT ["/bin/bash"]
