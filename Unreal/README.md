# Unreal Engine install

This is a base docker system with all of the pre-requiste tools installed.

You will need to download the source yourself as it is password protected via git.

```
git clone https://github.com/EpicGames/UnrealEngine.git 
cd UnrealEngine && \
./Setup.sh && \
./GenerateProjectFiles.sh && \ 
make -j 24
```


