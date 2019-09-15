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
             --env GRP_ID=$(id -g)                     \
             --env TZ="America/Los_Angeles"            \
          --volume $temp/config:/config                \
          --volume $temp/logs:/logs                    \
          --volume $temp/cache:/cache                  \
          --volume $temp/backuproot:/backuproot:ro     \
          --volume $temp/storage:/storage              \
                   saspus/duplicacy-web 
