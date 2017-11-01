#set the base image
FROM jmacey/nccabase
# Dockerfile author / maintainer 
MAINTAINER Jon Macey  <jmacey@bournemouth.ac.uk> 
# Set some arguments for finding the nvidia drivers



# Setup  Home
WORKDIR /home/ncca
ENV HOME /home/ncca
# add qt to path
ENV PATH=${PATH}:/opt/qt/bin
RUN git clone --depth 1 https://github.com:/NCCA/NGL && \
cd NGL && qmake && make -j 12 

# set default command
ENTRYPOINT ["/bin/bash"]
