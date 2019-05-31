#!/usr/bin/env bash

function terminator() { 
  echo 
  echo "Terminating pid ${child}...." 
  kill -TERM "${child}" 2>/dev/null
  echo "Exiting."
}

trap terminator SIGHUP SIGINT SIGQUIT SIGTERM

# Overhauling userbase. Sinlge home directory for root and duplicacy user
echo "root:x:0:root" > /etc/group
echo "root:x:0:0:root:/duplicacy:/bin/ash" > /etc/passwd

# Adding user-specified user
if [ $GRP_ID -ne 0 ] && [ $USR_ID -ne 0 ]; then 
    addgroup -g $GRP_ID -S duplicacy;
    adduser  -u $USR_ID -S duplicacy -G duplicacy -h /duplicacy;  
fi
 
# Configuring folders and permissions    
mkdir -p  /config /config/bin /logs /cache

# Force-symlink duplicacy folder into external volume
ln -s -f /config/  /duplicacy/.duplicacy-web

# Initialize settings.json if absent in the persisted config
if [ ! -f /config/settings.json ]; then
    jq -n '.listening_address = "0.0.0.0:3875"' > /config/settings.json
fi

# Always override log and temp direcoty
jq '.log_directory = "\/logs" | .temporary_directory = "\/cache"' 	/config/settings.json

# Create a duplicacy.json file if absent in the persisted config 
if [ ! -f /config/duplicacy.json ]; then
    echo '{}'   > /config/duplicacy.json
fi

# Override the CLI version duplicacy_web would use to $DUPLICACY_CLI_VERSION
jq --arg version $DUPLICACY_CLI_VERSION '.cli_version = $version' /config/duplicacy.json

# Force symlink to downloaded and baked in CLI to where duplicacy_web expects it 
ln -s -f /usr/local/bin/${DUPLICACY_CLI_FILENAME} /config/bin/${DUPLICACY_CLI_FILENAME}


# Create a log file if absent
touch /logs/duplicacy_web.log

# set ownership on the home folder
chown -R $USR_ID:$GRP_ID    /config /logs /cache /duplicacy


# Preparing persistent unique machine ID
if ! dbus-uuidgen --ensure=/config/machine-id; then 
    echo machine-id contains invalid data. Regenerating.
    dbus-uuidgen > /config/machine-id
fi

echo Using machine-id = $(cat /var/lib/dbus/machine-id)

echo "Logging tail of the log from this moment on"
su-exec $USR_ID:$GRP_ID tail -0 -f /logs/duplicacy_web.log & 

echo "Starting duplicacy as user $(id -un):$(id -gn)\($(id -u):$(id -g)\)"
su-exec $USR_ID:$GRP_ID duplicacy_web & 

child=$!
wait "$child"