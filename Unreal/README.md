# Unreal Engine install

This is a base docker system with all of the pre-requiste tools installed.

Post install run the docker and update timezone (needed for Mono)
``` 
sudo apt-get install tzdata
```

You will need to download the source yourself as it is password protected via git.

First we need to setup timezone as it is not done in the build, this is needed by the unreal build scripts and git

```
sudo apt-get install tzdata
```

Follow the instructions and choose Europe and London.

Now download and build the engine.

```
git clone https://github.com/EpicGames/UnrealEngine.git 
```

Follow instructions [here](https://wiki.unrealengine.com/Running_On_Linux#Source_Code_Accessors) to update for Qt development.

```
cd UnrealEngine/Engine/Config/Linux/
vi LinuxEngine.ini
```

Add 

```
 [/Script/SourceCodeAccess.SourceCodeAccessSettings]
     PreferredAccessor=QtCreatorSourceCodeAccessor
```

```
cd ~/UnrealEngine/Engine/Plugins/Developer && git clone https://github.com/fire/QtCreatorSourceCodeAccess
```


```
cd UnrealEngine && \
./Setup.sh && \
./GenerateProjectFiles.sh && \ 
make -j 24
```


