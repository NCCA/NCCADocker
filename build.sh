#!/bin/bash
# get driver version
nvVersion=`nvidia-smi --query-gpu=driver_version --format=csv | sed -n 2p`
download="http://us.download.nvidia.com/XFree86/Linux-x86_64/$nvVersion/NVIDIA-Linux-x86_64-$nvVersion.run"
echo $nvVersion $download

