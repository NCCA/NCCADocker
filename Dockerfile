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
SDL2_ttf-devel.x86_64 SDL2_net-devel.x86_64 boost-devel.x86_64

# install same nVidia drivers as in Lab
# If you are using at home you may need to change the driver version to match your own
RUN echo "Downloading Nvidia ${nvidiaLocation} ${nvidiaRun} "
RUN cd /opt && \
  wget ${nvidiaLocation}   && \
  chmod +x $nvidiaRun  && \
  ./$nvidiaRun  -s -N --no-kernel-module  && \
  rm $nvidiaRun
# install Qt 
RUN cd /tmp  && \
wget http://download.qt.io/official_releases/qt/5.9/5.9.0/single/qt-everywhere-opensource-src-5.9.0.tar.xz  &>/dev/null && \
tar fxJ qt-everywhere-opensource-src-5.9.0.tar.xz && \
cd qt-everywhere-opensource-src-5.9.0  && \
./configure -confirm-license -opensource  -nomake examples -nomake tests -no-compile-examples  -no-xcb  -prefix "/opt/qt" && \
make -j 12  && \
make install && \
cd /tmp && rm -rf qt-everywhere-opensource-src-5.9.0 && \
rm /tmp/qt-everywhere-opensource-src-5.9.0.tar.xz 
# Setup  Home
WORKDIR /home/ncca
ENV HOME /home/ncca
# add qt to path
ENV PATH=${PATH}:/opt/qt/bin

# set default command
ENTRYPOINT ["/bin/bash"]
