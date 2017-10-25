#set the base image
FROM centos:7
# Dockerfile author / maintainer 
MAINTAINER Jon Macey  <jmacey@bournemouth.ac.uk> 

# Update Yum 
RUN yum update -y  && yum groupinstall 'Development Tools' -y 
RUN yum install -y cmake* clang* 
RUN yum install -y wget
# install same nVidia drivers as in Lab
# If you are using at home you may need to change the driver version to match your own
RUN cd /opt && \
  wget http://us.download.nvidia.com/XFree86/Linux-x86_64/375.66/NVIDIA-Linux-x86_64-375.66.run &>/dev/null && \
  chmod +x NVIDIA-Linux-x86_64-375.66.run && \
  ./NVIDIA-Linux-x86_64-375.66.run  -s -N --no-kernel-module  && \
  rm NVIDIA-Linux-x86_64-375.66.run


# set default command
ENTRYPOINT ["/bin/bash"]
