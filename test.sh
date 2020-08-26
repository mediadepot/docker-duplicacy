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

docker run  --name duplicacy-web-container             \
        --hostname duplicacy-web-docker                \
         --publish 4875:3875/tcp                       \
             --env USR_ID=$(id -u)                     \
             --env GRP_ID=$(id -g)                     \
             --env TZ="America/Los_Angeles"            \
          --volume $temp/config:/config                \
          --volume $temp/logs:/logs                    \
          --volume $temp/cache:/cache                  \
          --volume $temp/backuproot:/backuproot:ro     \
          --volume $temp/storage:/storage              \
                   saspus/duplicacy-web:latest
