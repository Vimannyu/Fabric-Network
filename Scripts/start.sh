
docker-compose -f ../Docker/docker-compose.yaml up -d

sleep 5
./createChannel.sh

sleep 2

./deployChaincode.sh
