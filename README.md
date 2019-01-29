# Duplicacy-Web wrapper

This is a wrapper around http://duplicacy.com web GUI. 

## Volumes 
`/config` -- is where configuration data will be stored. Should be backed up.

`/logs` --  logs will go there. 

`/cache` -- transient and temporary files will be stored here. Can be safely deleted.

## Environment variables 

### User
`USR_ID` and `GRP_ID` can be customized. Container will run as that user. By default user `0` (`root`) is used.

### Persistent machine-id
Duplicacy uses combination of machine-id and hostname to request the license. When container is rebuilt the machine-id can change. Settings `PERSISTENT_MACHINE_ID` variable to `true` will persist the machine-id in the configuration directory.

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
Note, it's imporatant to pass hostname, as duplicacy license is requested based on hostname and machine-id provided by dbus.

## To use
Go to http://hostname:3875

## Source
https://bitbucket.org/saspus/duplicacy-web-docker-container
