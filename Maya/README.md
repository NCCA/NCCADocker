# Base Docker for Maya Install

This docker file will build a base centos image for installing maya (tested on 2017) on a linux host. For testing purposes I have been using a Ubuntu (16.4 LTS) host computer on a Mac Book Pro using the nvidia drivers from the repos (Driver Version: 387.34) however the build.sh script will query the driver to ensure the correct version is installed.

This will build a docker container with the tag jmacey/dccbase this should be used to installe the DCC tools (in this case maya but it also works with Houdini and others).

## Installing Maya

Extract the maya install files on your home directory and start the docker image using the runDocker.sh script as follows

```
../runDocker.sh jmacey/dccbase
```

The will give you and interactive bash shell and you can change to your home directory using

```
cd /home/host/[username]
```

Locate the Maya install setup program and run it filling in the license details.

Once complete the following commands must be executed in the shell before running maya

```

dbus-uuidgen > /var/lib/dbus/machine-id 
mkdir -p /home/ncca/maya/2017 
echo "MAYA_DISABLE_CIP=1" >> /home/ncca/maya/2017/Maya.env 
echo "LC_ALL=C" >> /home/ncca/maya/2017/Maya.env 
echo "MAYA_OGS_GPU_MEMORY_LIMIT = 1024" >> ~/maya/2017/Maya.env
```

Maya should now run