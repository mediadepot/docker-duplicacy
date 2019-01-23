#!/usr/bin/env bash  

# trap ^C
trap 'kill ${!}; exit' SIGHUP SIGINT SIGQUIT SIGTERM
         
echo  "Creating duplicacy folders"
                                     
mkdir -p    ~/.duplicacy-web/logs \
            ~/.duplicacy-web/filters \
            ~/.duplicacy-web/repositories 
            
            
echo "Creating sane exports and files"
mkdir -p    /config/filters \
            /logs \
            /cache 

touch       /logs/duplicacy_web.log
            
            
echo '{"listening_address":"0.0.0.0:3875"}' > /config/settings.json
echo '{}'                                   > /config/duplicacy.json

echo "Link data to where duplicacy expects it"

ln -s /config/settings.json     ~/.duplicacy-web/settings.json                  
ln -s /config/duplicacy.json    ~/.duplicacy-web/duplicacy.json
ln -s /config/filters           ~/.duplicacy-web/filters
ln -s /logs                     ~/.duplicacy-web/logs
ln -s /cache                    ~/.duplicacy-web/repositories

echo "Logging tail of the log from this moment on"
tail -0 -f /logs/duplicacy_web.log & 

echo Starting duplicacy
duplicacy_web &

# wait for events.
wait
