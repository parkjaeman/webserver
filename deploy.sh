# aws login
aws ecr get-login --region ap-southeast-1 > temp.sh
chmod +x temp.sh
./temp.sh
rm temp.sh

# update image in repository
docker build -t 834160605896.dkr.ecr.ap-southeast-1.amazonaws.com/webserver:latest .
docker push 834160605896.dkr.ecr.ap-southeast-1.amazonaws.com/webserver:latest

# deployment as the updated image
curl -X DELETE -H "cluster_name: toledo-dev-v0.4" -H "service_name: webserver" http://52.221.249.75:8080/userService
sleep 10
curl --data-binary @webserver.yaml -H "Content-Type: text/plain" -H "cluster_name: toledo-dev-v0.4" -H "service_name: webserver" -H "command: create" -H "flags: -f" http://52.221.249.75:8080/userService
