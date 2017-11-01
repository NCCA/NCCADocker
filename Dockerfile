#set the base image
FROM centos:7
# Dockerfile author / maintainer 
MAINTAINER Jon Macey  <jmacey@bournemouth.ac.uk> 
# Set some arguments for finding the nvidia drivers
ARG nvidiaRun=NVIDIA-Linux-x86_64-375.66.run
ARG nvidiaLocation=http://us.download.nvidia.com/XFree86/Linux-x86_64/375.66/NVIDIA-Linux-x86_64-375.66.run

# Update Yum 
# instal the epel release repo (for SDL2 etc etc)
RUN yum install -y epel-release && \
yum update -y 

# install dev tools and required libs for NCCA dev
# these are all on one line as it makes it more cache friendly
RUN yum update -y  && yum groupinstall 'Development Tools' -y && \
yum install -y cmake* clang* && \
yum install -y wget && \
yum install -y vim && \ 
yum install -y ImageMagick-c++.x86_64 \
SDL2-devel.x86_64  SDL2_image-devel.x86_64 SDL2_mixer-devel.x86_64 \
SDL2_ttf-devel.x86_64 SDL2_net-devel.x86_64 boost-devel.x86_64 glew

# install same nVidia drivers as in Lab
# If you are using at home you may need to change the driver version to match your own
RUN echo "Downloading Nvidia ${nvidiaLocation} ${nvidiaRun} "
RUN cd /opt && \
  wget ${nvidiaLocation}   && \
  chmod +x $nvidiaRun  && \
  ./$nvidiaRun  -s -N --no-kernel-module  && \
  rm $nvidiaRun
# install Qt based on VFX reference platform  here https://github.com/mottosso/vfxplatform-docker/blob/master/Dockerfile-2018v3
# Clone git repositories
RUN cd /tmp && \
    git clone --recursive --branch 5.6.1 https://code.qt.io/qt/qt5.git qt5 && \
    rm -rf qt5/qtbase && \
    rm -rf qt5/qtx11extras && \
    git clone --recursive --branch adsk-contrib/vfx/5.6.1 https://github.com/autodesk-forks/qtbase.git qt5/qtbase && \
    git clone --recursive --branch adsk-contrib/vfx/5.6.1 https://github.com/autodesk-forks/qtx11extras.git qt5/qtx11extras && \
    git clone --recursive --branch 5.6 https://codereview.qt-project.org/pyside/pyside-setup pyside-setup

# will move this earlier in next build
RUN  yum install -y python-libs python-devel python-pip && \
    yum install -y libXrender* libxcb* xcb* fontconfig* freetype* libXi* libXext* libX11* libSM* libICE* libglib* libpthread* gstreamer* \
                   bison* flex* gperf* libicu-devel libxslt-devel ruby \
                   libgcrypt-devel libgcrypt pciutils-devel nss-devel libXtst-devel gperf cups-devel pulseaudio-libs-devel libgudev1-devel systemd-devel libcap-devel alsa-lib-devel flex bison ruby gcc-c++ dbus libXrandr-devel libXcomposite-devel libXcursor-devel dbus-devel fontconfig-devel && \
    yum install -y libxslt libxml2 libxml2-devel libxslt-devel cmake3 openssl*

# Configure, build and install Autodesk-forked Qt5
RUN cd /tmp/qt5 && \
    ./configure -opensource -confirm-license -nomake examples -nomake tests -prefix ="/opt/qt"
RUN cd /tmp/qt5 && \
    make -j 12
RUN cd /tmp/qt5 && \
    make install
RUN rm -rf /tmp/qt5
# download and copy glm header to /usr/include
RUN git clone https://github.com/g-truc/glm && \
cd glm && git checkout && git checkout 0.9.8 && \
cp -r glm /usr/include/
# Setup  Home
WORKDIR /home/ncca
ENV HOME /home/ncca
# add qt to path
ENV PATH=${PATH}:/opt/qt/bin

# set default command
ENTRYPOINT ["/bin/bash"]
