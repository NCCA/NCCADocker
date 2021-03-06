#set the base image
FROM centos:7
# Dockerfile author / maintainer 
MAINTAINER Jon Macey  <jmacey@bournemouth.ac.uk> 
# Set some arguments for finding the nvidia drivers
ARG nvidiaRun=NVIDIA-Linux-x86_64-375.66.run
ARG nvidiaLocation=http://us.download.nvidia.com/XFree86/Linux-x86_64/375.66/NVIDIA-Linux-x86_64-375.66.run
ARG cores=2
# add EPEL for extra repos
RUN yum install -y epel-release && \
yum update -y 
# install latest deve tools
RUN yum groupinstall -y "Development Tools" 
# these are the other libs we need so far.
RUN yum install -y clang  cmake3 wget zlib-devel qtcreator python2-pip  glew-devel libtiff-devel zlib-devel libpng-devel boost-devel bzip2-devel \
libjpeg-turbo-devel python-devel freetype-devel mlocate && \
pip install --upgrade pip && pip install numpy && updatedb
# install the nvidia drivers for our platform
RUN cd  && \
wget ${nvidiaLocation} &>/dev/null && \
chmod +x $nvidiaRun  && \
./$nvidiaRun  -s -N --no-kernel-module &>/dev/null && \   
rm $nvidiaRun  

# OpenEXR
RUN cd /root && \
wget -O openexr.zip  https://github.com/openexr/openexr/archive/develop.zip &>/dev/null  && \
unzip openexr.zip && cd /root/openexr-develop/IlmBase/ && ./bootstrap && ./configure && \
make -j $cores && make install && echo /usr/local/lib > /etc/ld.so.conf.d/OpenEXR.conf && ldconfig && \
cd /root/openexr-develop/OpenEXR && ./bootstrap && ./configure && \
make -j $cores && make install && \
cd /root/openexr-develop/PyIlmBase && ./bootstrap && ./configure && \
make -j4 && make install && cd /root && rm -rf /root/openexr* 

# OpenColourIO
RUN cd /root && wget -O ocio.zip https://github.com/imageworks/OpenColorIO/archive/master.zip && \
unzip ocio.zip && cd /root/OpenColorIO-master && mkdir build && cd build && \
cmake3 .. && make -j $cores && make install && rm -rf OpenColorIO* && \
cd /root && rm -rf *.zip

# OpenImage IO
RUN cd /root && wget -O oiio.zip https://github.com/OpenImageIO/oiio/archive/master.zip &>/dev/null && \
unzip oiio.zip && cd /root/oiio-master && \
mkdir build && cd build && cmake3 -DSTOP_ON_WARNING=0 .. && make -j $cores && \
make install && cd /root && rm -rf oiio*

# llvm (broken in repo!)
RUN cd /root && svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm && \
cd llvm/tools && svn co http://llvm.org/svn/llvm-project/cfe/trunk clang && \
cd ../.. && mkdir build && cd build && cmake3 -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm && \
make -j $cores && make install 
# Open Shading Language
RUN cd && wget -O osl.zip https://github.com/imageworks/OpenShadingLanguage/archive/master.zip && \
unzip osl.zip && cd OpenShadingLanguage-master  && mkdir build 


WORKDIR /home/ncca
ENV HOME /home/ncca
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib64/python2.7/site-packages/:/usr/local/lib
# set default command
SHELL ["/bin/bash","-c"]

