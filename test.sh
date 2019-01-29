docker build --tag=saspus/duplicacy-web .

docker run 	--name duplicacy-web-container	\
		--hostname duplicacy-web-docker \
            	-p 3875:3875/tcp		\
            	-v ~/Library/Duplicacy:/config 	\
            	-v ~/Library/Logs/Duplicacy/:/logs 	\
            	-v ~/Library/Caches/Duplicacy:/cache 	\
            	-v /tmp/backuproot:/backuproot:ro 	\
            	-v /tmp/storage:/storage 		\
            	saspus/duplicacy-web 
            
