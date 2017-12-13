#!/bin/bash
# find how many cores we have for building 
cores=`getconf _NPROCESSORS_ONLN`
echo "using " $cores "cores"
# first check if we have an nvidia driver installed
dockerFile="none"

if  [ -x "$(command -v nvidia-smi)" &>/dev/null ]; then
  echo 'Found installed nvidia driver' 
  dockerFile="Dockerfile"
fi
# if not see if default nouveau is installed
lsmod | grep nouveau &>/dev/null

if [ $? -eq 0 ]; then
    echo 'Found installed nouveau driver maya will not work with this'
    exit 1 
fi

if [ "$dockerFile" == "none"  ]; then
    echo "There is a good chance you have an ati driver installed"
    echo "I've not prepared this yet give me a machine with ATI and I will :-)"
    exit 1
fi

echo "using $dockerFile"

if [ "$dockerFile" == "Dockerfile" ]
then
    # get driver version obviously this is for nvidia as that is what we use
    # at the university. I will eventually add ati support (but need a card to test)
    # Run the query and extract the driver info which is on the 2nd line and will be a number such as 384.90 Note docker file will always have the default Uni driver
    nvVersion=`nvidia-smi --query-gpu=driver_version --format=csv | sed -n 2p`

    # construct two string to pass to docker, one is the dowload url used by wget
    download="http://us.download.nvidia.com/XFree86/Linux-x86_64/$nvVersion/NVIDIA-Linux-x86_64-$nvVersion.run"
    # run is the command to chmod +x and run in the docker file
    run="NVIDIA-Linux-x86_64-$nvVersion.run"
    # now run docker passing in these arguments
    #docker build --no-cache --build-arg nvidiaRun=$run --build-arg nvidiaLocation=$download -t jmacey/maya  --rm .
    echo $run $nvVersion
    docker build  --no-cache --build-arg nvidiaRun=$run --build-arg nvidiaLocation=$download --build-arg cores=$cores --rm  -t jmacey/osl  .
fi



