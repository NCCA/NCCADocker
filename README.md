# NCCA Docker Images and tools

This repo will contain all of the NCCA Docker images and tools. The base NCCA Dockerfile is used to build a base image the same as contained in the lab for small scale development.

It will use the same nVidia driver as installed in the labs, you may have to change this to get it to work with home machines.

Extra directories will be used to add other functionality to the base docker images.

It is always possible to download the base image from docker using the following command

docker pull jmacey/nccabase

To run with full GPU support you will need to use the runDocker.sh script 

```
#!/bin/bash
 docker run -it --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY  $@
```

for example

```
runDocker.sh jmacey/nccabase 

[root@1b0c4814a3cf /]# nvidia-smi
Wed Oct 25 15:03:24 2017
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 375.66                 Driver Version: 375.66                    |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Quadro M4000        Off  | 0000:02:00.0      On |                  N/A |
| 46%   32C    P8    13W / 120W |    147MiB /  8120MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID  Type  Process name                               Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
[root@1b0c4814a3cf /]#
```
