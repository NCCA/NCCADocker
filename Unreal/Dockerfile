#set the base image
FROM ubuntu
# Dockerfile author / maintainer 
MAINTAINER Jon Macey  <jmacey@bournemouth.ac.uk> 

# Update Yum 
RUN apt-get update 
RUN apt-get install -y wget

# install dev tools
RUN apt-get install -y build-essential
RUN apt-get install -y clang
RUN apt-get install -y git
RUN apt-get install -y cmake
RUN apt-get install -y mono-devel
RUN apt-get install -y mono-dmcs
# Need this for nVidia driver install
RUN apt-get install -y apt-utils module-init-tools 
RUN apt-get install -y kmod
# install same nVidia drivers as in Lab
# If you are using at home you may need to change the driver version to match your own
RUN cd /tmp && \
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/375.66/NVIDIA-Linux-x86_64-375.66.run && \
chmod +x NVIDIA-Linux-x86_64-375.66.run && \
./NVIDIA-Linux-x86_64-375.66.run  -s -N --no-kernel-module && \
rm NVIDIA-Linux-x86_64-375.66.run
# Clone and build Unreal

#thin up the whole images taken from here https://github.com/tweakmy/ue4-in-docker/blob/master/Dockerfile
RUN apt-get autoremove
RUN apt-get autoclean
RUN useradd -ms /bin/bash ncca
RUN adduser ncca sudo
# Setup  Home
WORKDIR /home/ncca
ENV HOME /home/ncca
# add qt to path
#ENV PATH=${PATH}:/opt/qt/bin

# set default command
ENTRYPOINT ["/bin/bash"]
