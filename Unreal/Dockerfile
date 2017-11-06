#set the base image
FROM ubuntu
# Dockerfile author / maintainer 
MAINTAINER Jon Macey  <jmacey@bournemouth.ac.uk> 
# Set some arguments for finding the nvidia drivers
ARG nvidiaRun=NVIDIA-Linux-x86_64-375.66.run
ARG nvidiaLocation=http://us.download.nvidia.com/XFree86/Linux-x86_64/375.66/NVIDIA-Linux-x86_64-375.66.run

# Update Yum 
RUN apt-get update && apt-get install -y wget build-essential clang 
RUN apt-get install -y git cmake mono-devel mono-dmcs apt-utils module-init-tools kmod sudo vim 
RUN apt-get install -y    libpangocairo-1.0-0  libnss3*  libxi-dev libxcursor-dev libxss-dev 
RUN apt-get install -y    libxcomposite-dev libasound2-dev libxdamage-dev  libxtst-dev libatk1.0-dev libxrandr-dev 
RUN apt-get install -y    qtcreator  

# install same nVidia drivers as in Lab
# If you are using at home you may need to change the driver version to match your own
RUN cd /opt && \
  wget ${nvidiaLocation}   && \
  chmod +x $nvidiaRun  && \
  ./$nvidiaRun  -s -N --no-kernel-module  && \
  rm $nvidiaRun
# Clone and build Unreal

#thin up the whole images taken from here https://github.com/tweakmy/ue4-in-docker/blob/master/Dockerfile
RUN apt-get autoremove && apt-get autoclean
#RUN useradd -ms /bin/bash ncca && adduser ncca sudo
RUN groupadd -r ncca  -g 901 && useradd ncca  -u 901 -r -g ncca 
RUN echo "ncca ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Setup  Home
WORKDIR /home/ncca
RUN chown ncca:ncca /home/ncca
ENV HOME /home/ncca
USER ncca
# add qt to path
#ENV PATH=${PATH}:/opt/qt/bin

# set default command
ENTRYPOINT ["/bin/bash"]
