aws configure set profile.prod.aws_access_key AKIAJWZQFLWB4QLGM3RQ
aws configure set profile.prod.aws_secret_access_key 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
aws configure set profile.prod.region ap-southeast-1
aws configure set profile.prod.output json

aws ecr get-login --region ap-southeast-1 > temp.sh
chmod +x temp.sh
./temp.sh
rm temp.sh

docker build -t 834160605896.dkr.ecr.ap-southeast-1.amazonaws.com/webserver:latest .
docker push 834160605896.dkr.ecr.ap-southeast-1.amazonaws.com/webserver:latest
curl -X DELETE -H "cluster_name: toledo-dev-v0.4" -H "service_name: webserver" http://52.221.249.75:8080/userService
sleep 10
curl --data-binary @webserver.yaml -H "Content-Type: text/plain" -H "cluster_name: toledo-dev-v0.4" -H "service_name: webserver" -H "command: create" -H "flags: -f" http://52.221.249.75:8080/userService
