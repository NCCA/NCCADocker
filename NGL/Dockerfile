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
RUN git clone https://github.com/g-truc/glm && \
cd glm && git checkout && git checkout 0.9.8 && \
cp -r glm /usr/include/ && rm -rf glm && \
cd  && git clone  https://github.com:/NCCA/NGL && \
cd NGL && qmake && make -j 12 

#git checkout pyngl && qmake && make -j 12 && git checkout master

# set default command
ENTRYPOINT ["/bin/bash"]
