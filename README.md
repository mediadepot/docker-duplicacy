# Duplicacy-Web wrapper

This is a wrapper around http://duplicacy.com web GUI. 

## Volumes 
`/config` -- is where configuration data will be stored. Should be backed up.

`/logs` --  logs will go there. 

`/cache` -- transient and temporary files will be stored here. Can be safely deleted.


## Environment variables 

### User
`USR_ID` and `GRP_ID` can be customized. Container will run as that user. By default user `0` (`root`) is used.

## To run
An example for appropriate volume mappings:
``` bash 
 docker run --name duplicacy-web-docker-container       \
            --hostname duplicacy-web-docker-instance    \
            -p 3875:3875/tcp                            \
            -v ~/Library/Duplicacy:/config              \
            -v ~/Library/Logs/Duplicacy/:/logs          \
            -v ~/Library/Caches/Duplicacy:/cache        \
            -v ~:/backuproot:ro                         \
            saspus/duplicacy-web
```
Note, it's imporatant to pass hostname, as duplicacy license is requested based on hostname and machine-id provided by dbus. Machine-id will be persisted in the /config directory.

## To use
Go to http://hostname:3875

## Source
https://bitbucket.org/saspus/duplicacy-web-docker-container
