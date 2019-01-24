# Duplicacy-Web wrapper

This is a wrapper around http://duplicacy.com web GUI. 

## Volumes 
`/config` -- is where configuration data will be stored. Need to be backed up.

`/logs` --  logs will go there. 

`/cache` -- transient and temporary files will be stored here.

## To run
An example for appropriate volume mappings:
``` bash 
 docker run --name duplicacy-web \
            -p 3875:3875/tcp \
            -v ~/Library/Duplicacy:/config  \
            -v ~/Library/Logs/Duplicacy/:/logs \
            -v ~/Library/Caches/Duplicacy:/cache \
            -v ~:/backuproot:ro \
            saspus/duplicacy-web
```
## To use
Go to http://hostname:3875

## Source
https://bitbucket.org/saspus/duplicacy-web-docker-container
