#!/bin/bash
# get driver version obviously this is for nvidia as that is what we use
# at the university. I will eventually add ati support (but need a card to test)

# Run the query and extract the driver info which is on the 2nd line and will be a number such as 384.90 Note docker file will always have the default Uni driver
nvVersion=`nvidia-smi --query-gpu=driver_version --format=csv | sed -n 2p`

# construct two string to pass to docker, one is the dowload url used by wget
download="http://us.download.nvidia.com/XFree86/Linux-x86_64/$nvVersion/NVIDIA-Linux-x86_64-$nvVersion.run"
# run is the command to chmod +x and run in the docker file
run="NVIDIA-Linux-x86_64-$nvVersion.run"
# now run docker passing in these arguments
docker build --build-arg nvidiaRun=$run --build-arg nvidiaLocation=$download -t jmacey/nccabase --rm . 
