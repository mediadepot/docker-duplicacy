#!/usr/bin/env bash  

echo Running entrypoint as $(id -un)
#trap 'kill ${!}; exit' SIGHUP SIGINT SIGQUIT SIGTERM

echo Operating under user $(id -un):$(id -gn)\($(id -u):$(id -g)\)

if [ ! -d ~/.duplicacy-web ]; then
    ln -s /config/  ~/.duplicacy-web
fi

touch /logs/duplicacy_web.log

if [ ! -f /config/settings.json ]; then
    echo '{
        "listening_address"     : "0.0.0.0:3875",
        "log_directory"         : "/logs",
        "temporary_directory"   : "/cache"
    }'          > /config/settings.json
fi

if [ ! -f /config/duplicacy.json ]; then
    echo '{}'   > /config/duplicacy.json
fi

echo "Logging tail of the log from this moment on"
tail -0 -f /logs/duplicacy_web.log & 

echo "Starting duplicacy"
exec duplicacy_web 

