#cleanup

echo Deleting container
export container=$(docker ps -a |grep duplicacy-web-container | awk '{print $1}');
if [ -n "$container"  ]; then 
    docker rm $container || exit 1
fi
echo Deleting Image
export image=$(docker images |grep saspus/duplicacy-web | awk '{print $3}')

if  [ -n "$image" ]; then
    docker rmi $image || exit 2
fi

temp=/tmp/dupl01
#rm -rf $temp
mkdir $temp
#chmod 777 $temp


# build
docker build --tag=saspus/duplicacy-web .                               || exit 1



#mkdir -p $temp/config $temp/logs $temp/cache $temp/storage $temp/backuproot
#touch $temp/backuproot/yadayada $temp/backuproot/yadayada2
#chown -R $(id -u):$(id -g) $temp/
#run 

docker run  --name duplicacy-web-container             \
        --hostname duplicacy-web-docker                \
         --publish 3875:3875/tcp                       \
            --env USR_ID=$(id -u)                     \
            --env GRP_ID=$(id -g)                       \
          --volume $temp/config:/config                \
          --volume $temp/logs:/logs                    \
          --volume $temp/cache:/cache                  \
          --volume $temp/backuproot:/backuproot:ro     \
          --volume $temp/storage:/storage              \
                   saspus/duplicacy-web 


### STASH


# https://github.com/moby/moby/issues/5509#issuecomment-45243772
#CMD ["sh", "-c","/usr/local/bin/init.sh ${DUPLICACY_CLI_VERSION} ${DUPLICACY_CLI_FILENAME}"] 
#echo init.sh runing as user $(id -un):$(id -gn)\($(id -u):$(id -g)\)
