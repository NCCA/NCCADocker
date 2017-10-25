#set the base image
FROM jmacey/nccabase
# Dockerfile author / maintainer 
MAINTAINER Jon Macey  <jmacey@bournemouth.ac.uk> 

# Install PIP  
RUN cd /opt && \
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
python get-pip.py && \
rm get-pip.py
# SciPi / NumPi
RUN yum install -y python-devel
RUN yum install -y scipy
RUN cd /opt && \
git clone https://github.com/Lasagne/Lasagne.git && \
cd Lasagne && \
pip install -r requirements.txt && \
cd .. && \
rm -rf Lasagne 
# Get CUDA
RUN cd /opt && \
wget  http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run &>/dev/null  && \
chmod +x cuda_7.5.18_linux.run && \
./cuda_7.5.18_linux.run --silent --toolkit --override && \
rm cuda_7.5.18_linux.run
# set default command
ENTRYPOINT ["/bin/bash"]
